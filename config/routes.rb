Rails.application.routes.draw do
  root to: 'pages#home'
  get '/welcome', to: 'pages#welcome', as: 'welcome'

  devise_for :users, controllers: { registrations: "registrations" }
  resources :user_steps

  patch '/match_results/:id/confirm', to: 'match_results#confirm', as: 'confirm'

  resources :users, only: [ :index, :show, :edit, :update ] do
    resources :user_reviews, only: [:new, :create, :destroy]
    get '/my_matches', to: 'matches#player_matches', as: 'my_matches'
    get '/my_agenda', to: 'events#player_events', as: 'my_agenda'
    resources :events, only: [:new, :create, :destroy]
  end

  get '/rankings', to: 'users#rankings', as: 'rankings'

  resources :matches, only: [:index, :show, :new, :create, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
