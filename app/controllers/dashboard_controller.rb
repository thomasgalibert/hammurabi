class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def redirect
    if current_user.accountant?
      redirect_to accounting_monthly_reports_path
    else
      redirect_to dossiers_path
    end
  end
end