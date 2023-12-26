resources :settings, only: [:index]

namespace :settings do
  resource :facturation_setting
  resource :firm_setting
  resource :communication do
    put :regenerate_accountant_token
  end
end