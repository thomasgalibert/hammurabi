class Sharing::DossierShareLinksController < ApplicationController
  before_action :check_link_and_token

  def show
    
  end

  private

  def check_link_and_token
    @dossier_share_link = DossierShareLink.find_by(id: params[:id], token: params[:token])
    if @dossier_share_link.nil?
      flash[:alert] = t('asks.flash.link_invalid')
      redirect_to root_path
    else
      @dossier = @dossier_share_link.dossier
      @contact = @dossier_share_link.contact
    end
  end
end