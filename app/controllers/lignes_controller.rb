class LignesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_facture

  def create
    @ligne = @facture.lignes.create!(ligne_params)
    respond_to do |format|
      format.html { redirect_to dossier_facture_path(@dossier, @facture) }
      format.turbo_stream 
    end
  end

  private

  def set_facture
    @facture = current_user.factures.find(params[:facture_id])
    @dossier = @facture.dossier
  end

  def ligne_params
    params.require(:ligne).permit(:description, :quantite, :prix_unitaire, :tva, :reduction)
  end
end