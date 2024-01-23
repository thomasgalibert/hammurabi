class SlipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dossier
  before_action :set_slip, only: [:show]

  def new
    @slip = @dossier.slips.new
  end

  def create
    @slip = @dossier.slips.create!(slip_params)
    redirect_to dossier_slip_path(@dossier, @slip)
  end

  def show
    
  end

  private

  def set_dossier
    @dossier = current_user.dossiers.find(params[:dossier_id])
  end

  def set_slip
    @slip = @dossier.slips.find(params[:id])
  end

  def slip_params
    params.require(:slip).permit(:recipient, :date)
  end
end