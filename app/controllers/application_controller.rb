class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Authentication
  include TeamAuthorization
  
  helper_method :current_user
  helper_method :user_signed_in?
  
end
