class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_dossier, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = current_user.notes
  end

  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      redirect_to @dossier, notice: t('notes.flash.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @note.update(note_params)
      redirect_to @dossier, notice: t('notes.flash.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to @dossier, notice: t('notes.flash.destroyed') }
      format.turbo_stream
    end
  end

  private

  def set_dossier
    @dossier = current_user.dossiers.find(params[:dossier_id])
  end

  def set_note
    @note = current_user.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:dossier_id, :content)
  end
end