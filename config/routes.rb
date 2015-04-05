Rails.application.routes.draw do
  root "home_page#show"

  resources :listings, only: [:index, :show]

  resources :users, only: [:new, :create, :show, :update], param: 'slug'

  resource :cart, only: [:show, :create, :destroy]
  post '/listings/:id/update_cart', to: 'carts#update'

  resources :categories, only: [:index, :show]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :users, as: :user, path: "/:slug" do
    resources :bookings, only: [:show, :index, :create]
  end

  namespace :hosts, as: :host, path: "/:slug" do
    resources :listings, only: [:index]
    resources :bookings, only: [:index, :show, :update]
  end

  namespace :admin do
    namespace :hosts, as: :host, path: "/:slug" do
      resources :listings
      resources :bookings
    end
      get "/", to: "dashboard#index"
      resources :categories
      resources :users, only: [:index, :show, :update],  param: 'slug'
  end

end
