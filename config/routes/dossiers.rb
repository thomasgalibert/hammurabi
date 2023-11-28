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
end