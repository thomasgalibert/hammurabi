class Ical::UsersController < ApplicationController
  before_action :check_token

  def show
    @events = @user.events.importants
      .where("date >= ? AND date <= ?", (Time.zone.now - 30.days), (Time.zone.now + 360.days))
      .order(date: :asc)

    cal = Icalendar::Calendar.new
    cal.x_wr_calname = "Hammurabi"

    cal.timezone do |t|
      t.tzid = "Europe/Paris"

      t.daylight do |d|
        d.tzoffsetfrom = "+0100"
        d.tzoffsetto   = "+0200"
        d.tzname       = "CEST"
        d.dtstart      = "19700308T020000"
        d.rrule        = "FREQ=YEARLY;INTERVAL=1;BYDAY=-1SU;BYMONTH=3"
      end

      t.standard do |s|
        s.tzoffsetfrom = "+0200"
        s.tzoffsetto   = "+0100"
        s.tzname       = "CET"
        s.dtstart      = "19701101T020000"
        s.rrule        = "FREQ=YEARLY;INTERVAL=1;BYDAY=-1SU;BYMONTH=10"
      end
    end

    @events.each do |event|
      cal.event do |e|
        e.dtstart     = Icalendar::Values::DateTime.new(event.date)
        e.dtend       = Icalendar::Values::DateTime.new(event.date + 1.hour)
        e.summary     = event.title
        e.description = event.dossier.name
      end
    end
    
    cal.publish
    
    respond_to do |format|
      format.ics { render plain: cal.to_ical }
    end
  end

  private

  def check_token
    if params[:token].blank?
      render plain: "No token", status: :unauthorized
    else
      @user = User.find_by(ical_token: params[:token])
      if @user.blank?
        render plain: "Wrong token", status: :unauthorized
      end
    end
  end
end