resources :factures do
  resources :payments
  resources :lignes do
    member do
      put :sort
    end
  end
end