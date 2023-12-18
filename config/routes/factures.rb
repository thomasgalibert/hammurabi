resources :factures do
  resources :payments
  resources :avoirs
  resources :lignes do
    member do
      put :sort
    end
  end
end