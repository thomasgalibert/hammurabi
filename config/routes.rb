Rails.application.routes.draw do
  draw :authentications
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
end
