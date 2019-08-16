Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: { registrations: "registrations" }
  resources :user_steps

  # resources :sign_ups
  # resources :finish_profiles

  # resources :challenges, only: [:index, :show, :update] do
  # end

  resources :matches, only: [:new, :create, :show, :index, :edit, :update]

  patch '/match_results/:id/confirm', to: 'match_results#confirm', as: 'confirm'

   resources :users, only: [ :index, :show, :edit, :update ] do
    resources :user_reviews, only: [:new, :create, :destroy]
  end

  # post 'challenges', to:'challenges#create', as: :create_challenge

  # patch 'challenges/:id/accept', to: 'challenges#accept', as: :accept_challenge
  # patch 'challenges/:id/decline', to: 'challenges#decline', as: :decline_challenge
  # patch 'challenges/:id/cancel', to: 'challenges#cancel', as: :cancel_challenge
  # patch 'challenges/:id/played', to: 'challenges#played', as: :played_challenge

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
