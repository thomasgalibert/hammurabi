class Dashboard::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete

  def index
    start_date = params.fetch(:start_date, Date.today).to_date
    @events = current_user.events
              .importants
              .where(date: start_date.beginning_of_week..start_date.end_of_week)
    
    @events_next_3_weeks = current_user.events
              .importants
              .where(date: start_date.beginning_of_week..start_date.end_of_week + 3.weeks)
  end
end