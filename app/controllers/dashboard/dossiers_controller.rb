class Dashboard::DossiersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete

  def index
    @q = current_user.dossiers.order([created_at: :desc]).ransack(params[:q])
    @pagy, @dossiers = pagy(@q.result)
  end
end