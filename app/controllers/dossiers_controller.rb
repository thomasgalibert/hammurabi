class DossiersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dossier, only: [:show, :edit, :update, :destroy]

  def index
    @dossiers = current_user.dossiers
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
      redirect_to @dossier, notice: t('dossiers.flash.updated')
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
    params.require(:dossier).permit(:name, :description)
  end
end
