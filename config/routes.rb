Rails.application.routes.draw do
  root "home_page#index"

  resources :items, only: [:index, :show]

  resources :categories, only: [:index, :show]

  resources :orders, only: [:index, :create]

  get "/cart", to: "cart#index"

  post "/cart", to: "cart#create"

  delete "/cart", to: "cart#destroy"

  get "/login", to: "sessions#new"

  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    get "/", to: "dashboard#index"

    resources :items

    resources :categories, except: [:update, :destroy]

    resources :orders, only: [:index, :show, :update]

    resources :item_categories, except: [:index]
  end

end
