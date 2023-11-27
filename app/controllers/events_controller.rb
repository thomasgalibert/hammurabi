class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:edit, :update, :destroy]

  def create
    @event = current_user.events.create(event_params)
    redirect_to @event.dossier
  end

  def edit
  end

  def update
    @event.update(event_params)

    respond_to do |format|
      format.html { redirect_to @event.dossier }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@event, partial: "events/event", locals: { event: @event }) }
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to @event.dossier }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@event) }
    end
  end

  private

  def set_event
    @event = current_user.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :kind, :date, :dossier_id)
  end

end