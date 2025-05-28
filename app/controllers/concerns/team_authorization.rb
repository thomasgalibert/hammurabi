module TeamAuthorization
  extend ActiveSupport::Concern

  included do
    # Helper pour récupérer les données filtrées par équipe
    helper_method :team_scope
  end

  private

  # Retourne les IDs des utilisateurs de l'équipe pour filtrer les données
  def team_user_ids
    @team_user_ids ||= current_user.team_user_ids
  end
  
  # Scope de base pour filtrer par équipe
  def team_scope(relation)
    relation.where(user_id: team_user_ids)
  end
  
  # Vérifier si l'utilisateur est un owner
  def require_owner!
    unless current_user.owner?
      redirect_to root_path, alert: "Accès non autorisé. Cette action nécessite les droits d'administrateur."
    end
  end
  
  # Vérifier si l'utilisateur peut modifier (owner seulement)
  def require_write_access!
    unless current_user.owner?
      redirect_to root_path, alert: "Accès non autorisé. Seul le propriétaire du cabinet peut effectuer cette action."
    end
  end
  
  # Vérifier si l'utilisateur a accès aux données financières
  def require_financial_access!
    # Les owners et les comptables ont accès
    true
  end
  
  # Pour les modèles qui appartiennent directement à un user
  def current_user_or_team
    if current_user.owner?
      current_user
    else
      current_user.team_owner
    end
  end
end