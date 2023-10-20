class SessionsController < ApplicationController
  def destroy
    logout current_user
    redirect_to root_path, notice: t('sessions.destroy')
  end
end