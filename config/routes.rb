# frozen_string_literal: true

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  # Third Party Authentication
  get 'auth/:provider/callback', to: 'sessions#create', as: 'omniauth_callback'
  get "/auth/failure", to: "sessions#omniauth_failure", as: "omniauth_failure"
  get '/login', to: 'sessions#new', as: 'login'
  match '/logout', to: 'sessions#destroy', via: [:get, :post], as: 'logout'

  get '/user/profile', to: 'user#profile', as: :user_profile

  root to: 'map#index', as: 'root'
  get '/state/:state_symbol' => 'map#state', :as => :state_map
  get '/state/:state_symbol/county/:std_fips_code' => 'map#county', :as => :county

  get '/ajax/state/:state_symbol' => 'ajax#counties'

  # Routes for Events
  resources :events, only: %i[index show]
  get '/my_events/new' => 'my_events#new', :as => :new_my_event
  post '/my_events/new', to: 'my_events#create'
  get '/my_events/:id' => 'my_events#edit', :as => :edit_my_event
  match '/my_events/:id', to: 'my_events#update', via: %i[put patch]
  delete '/my_events/:id', to: 'my_events#destroy'

  # Routes for Representatives
  resources :representatives, only: [:index]
  resources :representatives do
    resources :news_items, only: %i[index show]
    get '/representatives/:representative_id/my_news_item/new' => 'my_news_items#new',
        :as                                                    => :new_my_news_item
    post '/representatives/:representative_id/my_news_item/new', to: 'my_news_items#create'
    get '/representatives/:representative_id/my_news_item/:id' => 'my_news_items#edit',
        :as                                                    => :edit_my_news_item
    match '/representatives/:representative_id/my_news_item/:id', to:  'my_news_items#update',
                                                                  via: %i[put patch]
    delete '/representatives/:representative_id/my_news_item/:id', to: 'my_news_items#destroy'
  end
  get '/search/(:address)' => 'search#search', :as => 'search_representatives'
end
