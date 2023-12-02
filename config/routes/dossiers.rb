resources :dossiers do
  
  resources :todos do
    collection do
      get :completed
    end
  end

  resources :events
  resources :contacts
  resources :documents
  resources :conventions
  resources :notes

  resources :factures do
    member do
      get :will_complete
      put :complete
    end
  end
end