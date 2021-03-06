Chicagofood::Application.routes.draw do

  if Rails.env.production?
    constraints(:host => /^(?!chicagofood\.co)/i) do
      match "/(*path)" => redirect {
        |params, req| "https://chicagofood.co/#{params[:path]}"
      },  via: [:get, :post]
    end
  end

  resources :neighborhoods
  resources :venuetypes
  resources :ratings
  resources :comments
  resources :tries
  resources :item_ratings
  resources :eats

  resources :users, :path => 'u' do
  	resources :comments
  	resources :ratings
  	resources :tries
    resources :item_ratings
    resources :eats
    resources :lists do
      resources :list_items
    end
  end

  resources :venues do
  	resources :comments
  	resources :ratings
  	resources :tries
    resources :items
    resources :eats
  	get 'rating_average'
  end

  devise_for :users, path_names: { sign_up: 'register' }, :controllers => { :registrations => 'registrations' }

  get 'search' => 'welcome#search'
  get 'map' => 'welcome#map'
  get 'about' => 'welcome#about'
  get 'deletion_request' => 'welcome#deletion_request'
  put 'deletion_request' => 'welcome#deletion_request'
  get 'venues_controller/update_item_rating_display', to: 'venues#update_item_rating_display'
  get 'venues_controller/new_venue_search_display', to: 'venues#new_venue_search_display'

	root "welcome#index"

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :venues
      resources :neighborhoods
      resources :venuetypes
      resources :users do
        resources :comments
        resources :ratings
        resources :tries
        resources :item_ratings
        resources :lists
      end
    end
  end

end
