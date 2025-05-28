namespace :admin do
  resources :team_members, only: [:index, :new, :create, :destroy]
end