resources :todos do
  member do
    put :sort
    put :toggle
  end
end