resources :settings, only: [:index]

namespace :settings do
  resource :facturation_setting
  resource :firm_setting
  resource :communication
end