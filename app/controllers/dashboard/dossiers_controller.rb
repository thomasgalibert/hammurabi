class Dashboard::DossiersController < ApplicationController
  before_action :authenticate_user!

  def index
    dossiers = current_user.dossiers.order([:name]).ransack(params[:q])
    @pagy, @dossiers = pagy(dossiers.result)
  end
end