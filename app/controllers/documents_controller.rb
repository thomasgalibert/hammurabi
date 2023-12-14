class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_document, only: [:edit, :update, :destroy]

  def create
    @document = current_user.documents.create(document_params)
    redirect_to @document.dossier
  end

  def edit
  end

  def update
    @document.update(document_params)

    respond_to do |format|
      format.html { redirect_to @document.dossier }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@document, partial: "documents/document", locals: { document: @document }) }
    end
  end

  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to @document.dossier }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@document) }
    end
  end

  private

  def set_document
    @document = current_user.documents.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:name, :dossier_id, :fichier)
  end
end