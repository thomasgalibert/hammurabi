class ConventionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_dossier, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_convention, only: [:show, :edit, :update, :destroy]

  def new
    @convention = current_user.conventions.new
  end

  def create
    @convention = current_user.conventions.new(convention_params)
    if @convention.save
      redirect_to @dossier, notice: t('conventions.flash.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @convention.update(convention_params)
      redirect_to @dossier, notice: t('conventions.flash.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @convention.destroy
    respond_to do |format|
      format.html { redirect_to @dossier, notice: t('conventions.flash.destroyed') }
      format.turbo_stream
    end
  end

  private

  def set_dossier
    @dossier = current_user.dossiers.find(params[:dossier_id])
  end

  def set_convention
    @convention = current_user.conventions.find(params[:id])
  end

  def convention_params
    params.require(:convention).permit(
      :title, :date, :forfait, :fichier, :variable, :dossier_id)
  end
end