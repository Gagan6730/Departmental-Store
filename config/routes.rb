Rails.application.routes.draw do

  resources :users
  resources :catalog_items


  get '/user/orders', to: 'order#index'
  match "user/billing" => "catalog_items#billing", as: :billing, via: [:get, :post]
  post '/user/add/', to: 'catalog_items#addToCart'
  post '/user/remove/', to: 'catalog_items#removeFromCart'
  post '/user/clear/', to: 'catalog_items#clearCart'
  post '/user/validate/', to: 'catalog_items#validate_cart'


  match 'user/checkout' => "catalog__items#checkout", as: :checkout, via: [:get, :post]


  match "users/signin" => "users#signin", via: [:get, :post]
  # match "users/new" => "users#new", via: [:get, :post]
  # match "users/signup" => "users#signup", via: [:get, :post]
  #
  #
  resources :stores
  get '/dashboard/storedetails', to: 'store_controller#editStore'
  put '/dashboard/storedetails', to: 'store_controller#performEdit'
  get '/dashboard/billing', to: 'store_controller#billing'

  get '/logout', to:'users#logout'
  resources :add_inventory
  get '/dashboard/inventory', to: 'add_inventory#inventory'
  get '/inventory/search', to: 'add_inventory#searchInventory'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
