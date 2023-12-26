class ConclusionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_dossier, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_conclusion, only: [:show, :edit, :update, :destroy]

  def new
    @conclusion = current_user.conclusions.new
  end

  def create
    @conclusion = current_user.conclusions.new(conclusion_params)
    if @conclusion.save
      redirect_to @dossier, notice: t('conclusions.flash.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @conclusion.update(conclusion_params)
      redirect_to @dossier, notice: t('conclusions.flash.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @conclusion.destroy
    respond_to do |format|
      format.html { redirect_to @dossier, notice: t('conclusions.flash.destroyed') }
      format.turbo_stream
    end
  end

  private

  def set_dossier
    @dossier = current_user.dossiers.find(params[:dossier_id])
  end

  def set_conclusion
    @conclusion = current_user.conclusions.find(params[:id])
  end

  def conclusion_params
    params.require(:conclusion).permit(
      :name, :fichier, :dossier_id)
  end
end