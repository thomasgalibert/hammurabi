resources :factures do
  resources :lignes do
    member do
      put :sort
    end
  end
end