resources :dossiers do
  
  resources :todos do
    collection do
      get :completed
    end
  end

  resources :events

  resources :slips

  resources :document_share_links
  resources :dossier_share_links

  resources :contacts do
    member do
      get :new_existing
      post :add_existing
      delete :remove
    end
  end

  resources :documents do
    member do
      put :sort
      delete :delete_shared
      put :insert_slip
    end
  end
  
  resource :document_submission_schedule, only: [:show]
  
  resources :conventions
  resources :conclusions
  resources :notes
  
  resources :asks do
    collection do
      get :send_by_email
    end
  end

  resources :factures do
    member do
      get :will_complete
      put :complete
    end
  end
end