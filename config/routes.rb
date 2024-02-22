Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users

  resources :contacts, only: [:new, :create]

  root to: "categories#index"

  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
  get "pay", to: "pages#pay"
  get "delivery", to: "pages#delivery"

  get 'contacts/sent'

  resources :categories, only: [:index, :show]
  resources :products, only: [:index, :show]

  get 'cart', to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'
  post "/cart/add", to: "carts#add_to_cart"

  get '/recap_path', to: 'cart#recap'
end
