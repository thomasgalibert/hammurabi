class FacturesController < ApplicationController
  include Ordering
  before_action :authenticate_user!
  before_action :set_dossier, only: [:index, :new, :show, :edit, :update, :destroy]
  before_action :set_facture, only: [:show, :edit, :update, :destroy]
  before_action :check_contact_existence, only: [:new]

  def index
    @factures = current_user.factures
  end

  def new
    @facture = current_user.factures.create!(
      dossier: @dossier, 
      emetteur: current_user, 
      contact: @dossier.contact_principal,
      date: Date.today)

    redirect_to dossier_facture_path(@dossier, @facture)
  end

  def show
    initialize_row_order(@facture.lignes, order: :asc)  
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
    @facture.destroy
    respond_to do |format|
      format.html { redirect_to @dossier, notice: t('factures.flash.destroyed') }
      format.turbo_stream
    end
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

  def facture_params
    params.require(:facture).permit(
      :total_ht,
      :total_ttc,
      :locked,
      :contact_id,
      :date_fin_validite,
      :description
    )
  end
end