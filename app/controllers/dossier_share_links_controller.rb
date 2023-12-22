class DossierShareLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dossier
  before_action :set_contact
  before_action :set_dossier_share_link, only: [:destroy]
  include ActionView::RecordIdentifier

  def index
    
  end

  def create
    @dossier_share_link = DossierShareLink.create!(dossier: @dossier, contact: @contact)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          dom_id(@dossier, :dossier_share_links),
          partial: "dossier_share_links/link",
          locals: { contact: @contact, dossier: @dossier }
        )
      end
    end
  end

  def destroy
    @dossier_share_link.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          dom_id(@dossier, :dossier_share_links),
          partial: "dossier_share_links/link",
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

  def set_dossier_share_link
    @dossier_share_link = DossierShareLink.find(params[:id])
  end

end