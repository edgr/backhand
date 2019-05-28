Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users
  resources :challenges, only: [:index, :show, :create]

  patch 'challenge/:id/accept', to: 'challenge#accept', as: :accept_challenge
  patch 'challenge/:id/decline', to: 'challenge#decline', as: :decline_challenge
  patch 'challenge/:id/cancel', to: 'challenge#cancel', as: :cancel_challenge
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


