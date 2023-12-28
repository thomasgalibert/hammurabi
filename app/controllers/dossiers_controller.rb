class DossiersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_dossier, only: [:show, :edit, :update, :destroy]
  before_action :update_viewed_at, only: [:show, :edit]

  def index
    @dossiers = current_user.dossiers.actives.last_viewed(9)
  end

  def show
  end

  def new
    @dossier = current_user.dossiers.new
  end

  def create
    @dossier = current_user.dossiers.new(dossier_params)

    if @dossier.save
      redirect_to @dossier, notice: t('dossiers.flash.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @dossier.update(dossier_params)
      redirect_to @dossier
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dossier.destroy
    redirect_to dossiers_url, notice: t('dossiers.flash.destroyed')
  end

  private

  def set_dossier
    @dossier = current_user.dossiers.find(params[:id])
  end

  def dossier_params
    params.require(:dossier).permit(:name, :description, :category, :court, :rg_number)
  end

  def update_viewed_at
    @dossier.save
  end
end
