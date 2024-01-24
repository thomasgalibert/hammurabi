class SlipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dossier
  before_action :set_slip, only: [:show, :edit, :update]

  def new
    @slip = @dossier.slips.new(recipient: set_recipient(@dossier))
  end

  def create
    @slip = @dossier.slips.create!(slip_params)
    redirect_to dossier_slip_path(@dossier, @slip)
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        slip_pdf = SlipPdf.new(@slip)

        send_data slip_pdf.render, 
            filename: "bdc_#{k(@slip).number}_#{k(@dossier).name_as_url}.pdf", 
            type: "application/pdf", 
            disposition: "inline"
      end
    end
  end

  def edit
    
  end

  def update
    if @slip.update(slip_params)
      redirect_to dossier_slip_path(@dossier, @slip)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_dossier
    @dossier = current_user.dossiers.find(params[:dossier_id])
  end

  def set_slip
    @slip = @dossier.slips.find(params[:id])
  end

  def slip_params
    params.require(:slip).permit(:recipient, :date)
  end

  def set_recipient(dossier)
    if dossier.slips.any?
      dossier.slips.last.recipient
    else
      ""
    end
  end
end