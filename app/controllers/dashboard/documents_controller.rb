class Dashboard::DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete

  def index
    @q = current_user.documents.order([created_at: :desc]).ransack(params[:q])
    @pagy, @documents = pagy(@q.result)
  end
end