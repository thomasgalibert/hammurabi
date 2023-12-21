class AsksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_dossier_and_contact, only: [:index, :send_by_email]
  before_action :set_dossier, only: [:create, :edit, :update, :destroy]
  before_action :set_ask, only: [:edit, :update, :destroy]

  def index
    @asks = @dossier.asks.for_contact(@contact).without_document
    @ask = @dossier.asks.new(contact: @contact, user: current_user)
  end

  def edit
    
  end

  def create
    @ask = @dossier.asks.new(ask_params)
    if @ask.save
      redirect_to dossier_asks_path(@dossier, contact: @ask.contact), notice: t('asks.flash.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ask.update(ask_params)
      respond_to do |format|
        format.html { redirect_to dossier_asks_path(@dossier, contact: @contact), notice: t('asks.flash.updated') }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@ask, partial: "asks/ask", locals: { ask: @ask, dossier: @dossier, contact: @contact }) }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ask.destroy
    redirect_to dossier_asks_path(@dossier, contact: @contact), notice: t('asks.flash.destroyed')
  end

  def send_by_email
    ContactMailer.with(dossier: @dossier, contact: @contact).document.deliver_later
    redirect_to dossier_asks_path(@dossier, contact_id: @contact), notice: t('asks.flash.sent_by_email')
  end

  private

  def set_dossier_and_contact
    @dossier = current_user.dossiers.find(params[:dossier_id])
    @contact = @dossier.contacts.find(params[:contact_id])
  end

  def set_dossier
    @dossier = current_user.dossiers.find(params[:dossier_id])
  end

  def set_ask
    @ask = @dossier.asks.find(params[:id])
    @contact = @ask.contact
  end

  def ask_params
    params.require(:ask).permit(:contact_id, :user_id, :dossier_id, :name)
  end

end