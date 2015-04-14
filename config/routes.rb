require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  
  root "home_page#index"

  resources :listings, only: [:index, :show]

  resources :users, only: [:new, :create, :update], param: 'slug'
  resources :travelers, only: [:show]
  resources :hosts, only: [:show]

  resource :cart, only: [:show, :create, :destroy]

  resources :categories, only: [:index, :show]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :users, as: :user, path: "/:slug" do
    resources :reservations, only: [:update, :destroy]
    resources :bookings, only: [:index, :create]
  end

  namespace :hosts, as: :host, path: "/:slug" do
    resources :listings
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
