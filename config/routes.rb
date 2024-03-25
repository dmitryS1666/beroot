Rails.application.routes.draw do
  # devise_for :users

  resources :contacts, only: [:new, :create]

  root to: "categories#index"

  #search
  get 'results', to: 'results#index'
  get 'filters', to: 'results#filter'

  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
  get "pay", to: "pages#pay"
  get "delivery", to: "pages#delivery"
  get "privacy_policy", to: "pages#privacy_policy"
  get 'cookies' => 'pages#cookies'

  get 'contacts/sent'

  resources :categories, only: [:index, :show]
  resources :products, only: [:index, :show]

  get 'cart', to: 'cart#show'
  get '/checkout', to: 'cart#checkout'

  post 'cart/add'
  post 'cart/remove'
  post "/cart/add", to: "carts#add_to_cart"

  get '/recap_path', to: 'cart#recap'

  resources :feedbacks, only: [:new, :create]
  resources :newsletters, only: [:new, :create]
  post 'orders/sent'
end
