class DocumentSubmissionSchedulesController < ApplicationController
  before_action :authenticate_user!

  def show
    @dossier = current_user.dossiers.find(params[:dossier_id])

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
end