class DocumentsController < ApplicationController
  include Ordering
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_document, only: [:edit, :update, :destroy, :sort, :show]

  def upload
    @slip = current_user.slips.find(params[:slip_id])
    @dossier = @slip.dossier
    params = document_params.merge(dossier_id: @dossier.id, slip_id: @slip.id)
    @document = current_user.documents.new(params)
    @document.save
    redirect_to dossier_slip_path(@dossier, @slip)
  end

  def edit
  end

  def show
    respond_to do |format|
      format.pdf do
        send_data @document.stamped.to_pdf,
                  filename: "Piece_#{@document.position}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  def update
    @document.update(document_params)
    @dossier = @document.dossier
    @slip = @document.slip
    redirect_to dossier_slip_path(@dossier, @slip)
  end

  def destroy
    @ask = @document.ask
    delete_item_with_position(@document.slip.documents, @document)
    @ask.destroy if @ask.present?
    
    @dossier = @document.dossier
    @slip = @document.slip
    redirect_to dossier_slip_path(@dossier, @slip)
  end

  def sort
    new_position = params[:row_order_position].to_i+1
    reorder_items_with_acts_as_list(@document.slip.documents, @document, new_position)
    head :ok
  end

  private

  def set_document
    @document = current_user.documents.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:name, :dossier_id, :fichier, :slip_id, :position)
  end
end