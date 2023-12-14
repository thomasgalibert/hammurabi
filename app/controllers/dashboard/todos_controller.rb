class Dashboard::TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete

  def index
    @q = current_user.todos.incomplete.order([created_at: :desc]).ransack(params[:q])
    @pagy, @todos = pagy(@q.result)
  end
end