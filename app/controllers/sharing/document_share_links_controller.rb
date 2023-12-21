class Sharing::DocumentShareLinksController < ApplicationController
  before_action :check_link_and_token

  def show
    
  end

  private

  def check_link_and_token
    @document_share_link = DocumentShareLink.find_by(id: params[:id], token: params[:token])
    if @document_share_link.nil?
      flash[:alert] = t('asks.flash.link_invalid')
      redirect_to root_path
    else
      @dossier = @document_share_link.dossier
      @contact = @document_share_link.contact
    end
  end
end