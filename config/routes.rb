Rails.application.routes.draw do
  draw :sharing
  draw :contacts
  draw :searchs
  draw :settings
  draw :factures
  draw :dashboard
  draw :admin
  draw :todos
  draw :dossiers
  draw :authentications
  get "up" => "rails/health#show", as: :rails_health_check

  # Make a route constraint that redirect only if user signed in ?
  constraints ->(request) { request.session[:user_id].present? } do
    root "dossiers#index", as: :dashboard
  end

  root "home#index"
end
