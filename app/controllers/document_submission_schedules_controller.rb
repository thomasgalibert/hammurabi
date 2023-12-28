class DocumentSubmissionSchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_can_edit_document_submission_schedule

  def show
    respond_to do |format|
      format.pdf do
        document_submission_schedule_pdf = DocumentSubmissionSchedulePdf.new(@dossier)

        send_data document_submission_schedule_pdf.render, 
            filename: "bdc_#{k(@dossier).name_as_url}.pdf", 
            type: "application/pdf", 
            disposition: "inline"
      end
    end
  end

  private

  def check_if_can_edit_document_submission_schedule
    @dossier = current_user.dossiers.find(params[:dossier_id])

    unless @dossier.can_edit_document_submission_schedule?
      flash[:alert] = "Vous devez renseigner les contacts principaux, adverses et avocats adverses pour pouvoir éditer le bordereau de communication de pièces."
      redirect_to @dossier
    end
  end
end