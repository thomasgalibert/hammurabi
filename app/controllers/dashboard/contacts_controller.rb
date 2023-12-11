class Dashboard::ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:show]

  def show
    
  end

  private

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

end