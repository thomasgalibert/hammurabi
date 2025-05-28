class TeamMemberMailer < ApplicationMailer
  def invitation(team_member, temporary_password)
    @team_member = team_member
    @temporary_password = temporary_password
    @owner = team_member.team_owner
    
    mail(
      to: team_member.email,
      subject: "Invitation à rejoindre l'équipe comptable de #{@owner.firm}"
    )
  end
end