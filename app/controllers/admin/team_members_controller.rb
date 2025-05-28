class Admin::TeamMembersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner!
  before_action :set_team_member, only: [:destroy]

  def index
    @team_members = current_user.team_members
  end

  def new
    @team_member = current_user.team_members.build
  end

  def create
    @team_member = current_user.team_members.build(team_member_params)
    @team_member.role = "accountant"
    
    if @team_member.save
      redirect_to admin_team_members_path, notice: "Comptable créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @team_member.destroy
    redirect_to admin_team_members_path, notice: "Membre de l'équipe supprimé avec succès."
  end

  private

  def require_owner!
    redirect_to root_path, alert: "Accès non autorisé" unless current_user.owner?
  end

  def set_team_member
    @team_member = current_user.team_members.find(params[:id])
  end

  def team_member_params
    params.require(:user).permit(:email, :first_name, :last_name, :firm, :password, :password_confirmation)
  end
end