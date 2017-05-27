Rails.application.routes.draw do
  # get 'sessions/new'
  #
  # get 'users/new'
  #
  # get 'users/create'
  # get 'sessions/new'

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :users, only: [:new, :create]

  resources :products do
    resources :reviews, only: [:create, :destroy]
  end

  get '/contact', to: 'welcome#contact'

  post '/contact', to: 'welcome#submit'

  get '/', to: 'welcome#index', as: 'home'

  get '/about', to: 'welcome#about'

  # get '/products', to: 'products#index'

  # get '/products/new', to: 'products#new', as: 'new_product'
  # post '/products', to: 'products#create', as: 'products'
  # get '/products/:id', to: 'products#show', as: 'product'
  get '/products', to: 'products#index', as: 'all_products'
  # get '/products/:id/edit', to: 'products#edit', as: 'edit_product'
  # patch '/products/:id', to: 'products#update'
  # delete '/products/:id', to: 'products#destroy'




end
