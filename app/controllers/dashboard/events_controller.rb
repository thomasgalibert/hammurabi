class Dashboard::EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    start_date = params.fetch(:start_date, Date.today).to_date
    @events = current_user.events.where(date: start_date.beginning_of_week..start_date.end_of_week)
  end
end