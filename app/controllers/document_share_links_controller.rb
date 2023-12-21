class DocumentShareLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dossier
  before_action :set_contact
  include ActionView::RecordIdentifier

  def create
    @document_share_link = DocumentShareLink.create!(dossier: @dossier, contact: @contact)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          dom_id(@dossier, :document_share_links),
          partial: "document_share_links/link",
          locals: { contact: @contact, dossier: @dossier }
        )
      end
    end
  end

  def destroy
    @document_share_link = DocumentShareLink.find(params[:id])
    @document_share_link.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          dom_id(@dossier, :document_share_links),
          partial: "document_share_links/link",
          locals: { contact: @contact, dossier: @dossier }
        )
      end
    end
  end

  private

  def set_dossier
    @dossier = current_user.dossiers.find(params[:dossier_id])
  end

  def set_contact
    @contact = current_user.contacts.find(params[:contact_id])
  end
end
