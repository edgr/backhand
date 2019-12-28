Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resources :user_steps

  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    get '/:locale', to: 'pages#home'
    root to: 'pages#home'
    get '/welcome', to: 'pages#welcome', as: 'welcome'
    match '/404', to: 'errors#not_found', via: :all
    match '/500', to: 'errors#internal_server_error', via: :all

    patch '/match_results/:id/confirm', to: 'match_results#confirm', as: 'confirm'

    resources :users, only: [ :index, :show, :edit, :update ] do
      resources :user_reviews, only: [:new, :create, :destroy]
      resources :events, only: [:new, :create, :edit, :destroy]
    end

    get '/my_agenda', to: 'events#player_events', as: 'my_agenda'
    get '/my_matches', to: 'matches#player_matches', as: 'my_matches'
    get '/rankings', to: 'users#rankings', as: 'rankings'

    resources :matches, only: [:index, :show, :new, :create, :edit, :update]

    resources :clubs, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
