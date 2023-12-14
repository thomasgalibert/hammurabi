class Dashboard::ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_contact, only: [:show, :edit, :update]

  def index
    contacts = current_user.contacts.order([:last_name, :company_name]).ransack(params[:q])
    @pagy, @contacts = pagy(contacts.result)
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @contact.update(contact_params)
      redirect_to dashboard_contact_path(@contact), notice: t('contacts.flash.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(
      :kind,
      :last_name,
      :first_name,
      :company_name,
      :business_number,
      :vat_number,
      :email,
      :phone,
      :address,
      :zip_code,
      :city,
      :country)
  end

end