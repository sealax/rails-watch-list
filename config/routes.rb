Rails.application.routes.draw do
  root to: "lists#index"

  resources :lists do
    resources :bookmarks, only: [ :new, :create ]
  end

  resources :bookmarks, only: [ :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check
end
