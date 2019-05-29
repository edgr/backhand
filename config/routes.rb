Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users
  resources :challenges, only: [:index, :show] do
    resources :user_reviews, only: [:show, :create]
  end

   resources :users, only: [ :index, :show, :edit, :update ] do
    resources :user_reviews, only: [:destroy]
  end

  post 'challenges', to:'challenges#create', as: :create_challenge
  patch 'challenges/:id/accept', to: 'challenges#accept', as: :accept_challenge
  patch 'challenges/:id/decline', to: 'challenges#decline', as: :decline_challenge
  patch 'challenges/:id/cancel', to: 'challenges#cancel', as: :cancel_challenge

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


