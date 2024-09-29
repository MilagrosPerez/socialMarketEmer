Rails.application.routes.draw do
  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create], path: '/register', path_names: { new: '/'}
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: { new: '/'}
  end

    # Defines the root path route ("/")
  # root "posts#index"
  # root "products#index"
   #Cuando soliciten /products devuelvo el controlador products como me va a devolver un conjunto de cosas le agrego como nombre de metodo index
  # post '/products',     to: 'products#create'
  # get  '/products/new', to: 'products#new', as: :new_product
  # get  '/products',     to: 'products#index'
  # get  '/products/:id', to: 'products#show', as: :product
  # get  '/products/:id/edit', to: 'products#edit', as: :edit_product
  # patch '/products/:id', to: 'products#update'
  # delete '/products/:id', to: 'products#destroy'
  #Escribir resources products es equivalente a poner las 7 lineas de arriba

  resources :categories, except: :show
  resources :users, only: :show,  path: '/user' , param: :username
  resources :favorites, only: [:create, :destroy, :index], param: :product_id
    #ojo con el orden aca , la home / debe ir abajo
  resources :products, path: '/'
end
