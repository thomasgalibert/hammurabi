class SessionsController < ApplicationController

  def new
    
  end

  def create
    if user = User.authenticate_by(email: authenticate_params[:email], password: authenticate_params[:password])
      login user
      redirect_to root_path, notice: t('sessions.create')
    else
      flash[:alert] = t('sessions.invalid_credentials')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout current_user
    redirect_to root_path, notice: t('sessions.destroy')
  end

  private


  def authenticate_params
    params.permit(:email, :password, :authenticity_token, :commit)
  end
end