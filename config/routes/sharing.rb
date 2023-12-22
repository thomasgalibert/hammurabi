namespace :sharing do
  resources :document_share_links, only: [:show]
  resources :dossier_share_links, only: [:show]
  resources :documents, only: [:create]
end