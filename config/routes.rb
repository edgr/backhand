Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: { registrations: "registrations" }
  resources :user_steps

  resources :matches, only: [:show, :index]

  patch '/match_results/:id/confirm', to: 'match_results#confirm', as: 'confirm'

  resources :users, only: [ :index, :show, :edit, :update ] do
    resources :user_reviews, only: [:new, :create, :destroy]
    resources :matches, only: [:new, :create, :show, :edit, :update]
    get 'matches', to: 'matches#player_matches'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
