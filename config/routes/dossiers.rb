resources :dossiers do
  
  resources :todos do
    collection do
      get :completed
    end
  end

  resources :events

  resources :contacts do
    member do
      get :new_existing
      post :add_existing
      delete :remove
    end
  end

  resources :documents
  resources :conventions
  resources :notes

  resources :factures do
    member do
      get :will_complete
      put :complete
      post :refund
    end
  end
end