Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get('/about' => 'about#index')
  get('/contact' => 'contact#index')
  post('/contact_submit' => 'contact#create')

  resources :products do
    resources :reviews, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create]

  # get('/products/new', { to: 'products#new', as: 'new_product'})
  #
  # post('/products', { to: 'products#create', as: 'products' })
  #
  # get('/products/:id', { to: 'products#show',  as: 'product' })
  #
  # get('/products', { to: 'products#index' })
  #
  # get('/products/:id/edit', { to: 'products#edit', as: 'edit_product'})
  #
  # patch('/products/:id', { to: 'products#update' })
  #
  # delete('/products/:id', { to: 'products#destroy' })

  resources :sessions, only:[:new, :create] do
     delete :destroy, on: :collection
     #password does not show in the address url
   end

  root 'welcome#index'

end
