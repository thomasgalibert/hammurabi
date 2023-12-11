class Searchs::GlobalsController < ApplicationController
  before_action :authenticate_user!

  def index
    query = params[:query]
    results = []
    
    dossiers = current_user.dossiers.ransack(
                "name_cont": query,
                ).result.limit(50).distinct
    
    contacts = current_user.contacts.ransack(
                "last_name_or_company_name_cont": query,
                ).result.limit(50).distinct
    
    dossiers.each { |dossier| results << { name: dossier.name, url: dossier_path(dossier) } }
    contacts.each { |contact| results << { name: contact.name_with_company, url: dashboard_contact_path(contact) } }

    results.sort_by! { |result| result[:name] }
    render json: results
  end

end