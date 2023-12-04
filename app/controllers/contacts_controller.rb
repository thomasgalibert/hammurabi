class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dossier, only: [:new, :create, :show, :edit, :update, :destroy, :new_existing, :add_existing, :remove]
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :remove]

  def new
    @contact = current_user.contacts.new()
  end

  def new_existing
    @contacts = current_user.contacts
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      @dossier.contacts << @contact
      update_dossier_contact_main(@dossier, @contact, @contact.main)
      redirect_to @dossier, notice: t('contacts.flash.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def add_existing
    @contact = current_user.contacts.find(params[:contact_id])
    @dossier.contacts << @contact
    redirect_to @dossier, notice: t('contacts.flash.added')
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @contact.update(contact_params)
      update_dossier_contact_main(@dossier, @contact, @contact.main)
      redirect_to @dossier, notice: t('contacts.flash.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def remove
    @dossier.contacts.delete(@contact)
    respond_to do |format|
      format.html { redirect_to @dossier, notice: t('contacts.flash.removed') }
      format.turbo_stream
    end    
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to @dossier, notice: t('contacts.flash.destroyed') }
      format.turbo_stream
    end
  end

  private

  def set_dossier
    @dossier = current_user.dossiers.find(params[:dossier_id])
  end

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
      :country,
      :main)
  end

  def update_dossier_contact_main(dossier, contact, is_main)
    DossierContact.find_by(dossier: dossier, contact: contact).update(is_main: is_main)
  end
end