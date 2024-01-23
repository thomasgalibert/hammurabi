class DocumentsController < ApplicationController
  include Ordering
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_document, only: [:edit, :update, :destroy, :sort, :show]

  def create
    @document = current_user.documents.create(document_params)
    add_item_to_list_with_position(@document.dossier.documents, @document)
    redirect_to @document.dossier
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
    dossier = @document.dossier
    redirect_to dossier

    # respond_to do |format|
    #   # format.html { redirect_to dossier }
    #   # format.turbo_stream { render turbo_stream: turbo_stream.replace(@document, partial: "documents/document", locals: { document: @document, dossier: dossier }) }
    # end
  end

  def destroy
    @ask = @document.ask
    delete_item_with_position(@document.dossier.documents, @document)
    @ask.destroy if @ask.present?
    
    respond_to do |format|
      format.html { redirect_to @document.dossier }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@document) }
    end
  end

  def sort
    # Reorder the documents in the dossier according to the new position with acts_as_list
    new_position = params[:row_order_position].to_i+1
    reorder_items_with_acts_as_list(@document.dossier.documents, @document, new_position)
    head :ok
  end

  private

  def set_document
    @document = current_user.documents.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:name, :dossier_id, :fichier)
  end
end