class LignesController < ApplicationController
  include Ordering
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_facture
  before_action :set_ligne, only: [:sort, :edit, :update, :destroy]

  def new
    @ligne = @facture.lignes.new(quantite: 1, tva: 20, reduction: 0)
  end
  
  def create
    @ligne = @facture.lignes.new(ligne_params)

    if @ligne.save
      add_item_to_list(@facture.lignes, @ligne)
      
      respond_to do |format|
        format.html { redirect_to dossier_facture_path(@dossier, @facture) }
        format.turbo_stream 
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def sort
    new_position = params[:row_order_position].to_i+1
    reorder_items(@ligne.facturable.lignes.saved, @ligne, new_position)  
    head :no_content    
  end

  def edit
    
  end

  def update
    @ligne.update(ligne_params)
    respond_to do |format|
      format.html { redirect_to dossier_facture_path(@dossier, @facture) }
      format.turbo_stream
    end
  end

  def destroy
    @ligne.destroy
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

  def set_ligne
    @ligne = @facture.lignes.find(params[:id])
  end

  def ligne_params
    params.require(:ligne).permit(:description, :quantite, :prix_unitaire, :tva, :reduction, :unit)
  end
end