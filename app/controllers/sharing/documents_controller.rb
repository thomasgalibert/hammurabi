class Sharing::DocumentsController < ApplicationController
  before_action :check_link_and_token

  def create
    document = Document.new(document_params)
    if document.save
      redirect_to sharing_document_share_link_url(@document_share_link, token: @document_share_link.token)
      flash[:notice] = t('documents.flash.created')
    else
      redirect_to sharing_document_share_link_url(@document_share_link, token: @document_share_link.token)
      flash[:alert] = t('documents.flash.not_created')
    end
  end

  private

  def check_link_and_token
    @document_share_link = DocumentShareLink.find_by(token: params[:token])
    if @document_share_link.nil?
      flash[:alert] = t('asks.flash.link_invalid')
      redirect_to root_path
    end
  end

  def document_params
    params.require(:document).permit(:fichier, :ask_id, :user_id, :dossier_id, :name)
  end
end