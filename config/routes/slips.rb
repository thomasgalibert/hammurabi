resources :slips do
  resources :documents do
    collection do
      post :upload
    end
  end
end