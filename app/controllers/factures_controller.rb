class FacturesController < ApplicationController
  include Ordering
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_dossier, only: [:index, :new, :show, :edit, :update, :destroy, :will_complete, :complete]
  before_action :set_facture, only: [:show, :edit, :update, :destroy, :complete, :will_complete]
  before_action :check_contact_existence, only: [:new]
  before_action :check_firm_settings, only: [:new]

  def index
    @factures = current_user.factures
  end

  def new
    @facture = current_user.factures.create!(
      state: "draft",
      dossier: @dossier, 
      emetteur: current_user, 
      contact: @dossier.contact_principal,
      date: Date.today)

    redirect_to dossier_facture_path(@dossier, @facture)
  end

  def show
    initialize_row_order(@facture.lignes.saved, order: :asc)  

    respond_to do |format|
      format.html
      format.pdf do
        pdf = FacturePdf.new(@facture)
        send_data pdf.render, filename: "facture.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def edit
    
  end

  def update
    if @facture.update(facture_params)
      redirect_to [@dossier, @facture], notice: t('factures.flash.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @facture.draft?
      @facture.delete
      redirect_to @dossier, notice: t('factures.flash.destroyed')
    else
      redirect_to @dossier, alert: t('factures.flash.not_destroyed')
    end
  end

  def will_complete
    
  end

  def complete
    @facture.complete!
    redirect_to [@dossier, @facture], notice: t('factures.flash.completed')
  end

  private

  def set_dossier
    @dossier = current_user.dossiers.find(params[:dossier_id])
  end

  def set_facture
    @facture = current_user.factures.find(params[:id])
  end

  def check_contact_existence
    redirect_to @dossier, alert: t('factures.flash.no_contact') unless @dossier.contact_principal.present?
  end

  def check_firm_settings
    redirect_to @dossier, alert: t('factures.flash.no_firm_settings') unless current_user.firm_setting.present? && current_user.firm_setting.is_complete?
  end

  def facture_params
    params.require(:facture).permit(
      :total_ht,
      :total_ttc,
      :contact_id,
      :date_fin_validite,
      :description,
      :convention_id
    )
  end
end