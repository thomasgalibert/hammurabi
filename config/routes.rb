Rails.application.routes.draw do
  draw :slips
  draw :ical
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
  draw :accounting
  get "help" => "home#help", as: :help
  get "reach" => "home#reach", as: :reach
  get "up" => "rails/health#show", as: :rails_health_check

  # Make a route constraint that redirect only if user signed in ?
  constraints ->(request) { request.session[:user_id].present? } do
    root "dossiers#index", as: :dashboard
  end

  root "home#index"
end
