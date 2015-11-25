Rails.application.routes.draw do
   get 'admin/index'

   post 'admin/add_items' => 'admin#add_items'

   get 'admin/remove_items'

   get 'admin/manage_users'

   get '/cart/add' => 'cart#add'

   get '/cart/clear' => 'cart#clearcart'

   get '/cart_details' => 'cart#display_cart'
   get '/cart_update' => 'cart#cart_update'
   delete '/remove_cart' => 'cart#remove_cart'
   get '/paypal_response' => 'cart#paypal_response'
   root 'home#index'

   get 'users/new' => 'users#new'
   post '/save_cart' => 'cart#save_cart'
  resources :items

   get "/itemdescription" => "items#itemdescription"

   delete 'items/delete' => 'items#delete'
   post 'users/register' => 'users#register'
   get 'users/getlogin' => 'users#getlogin'
   post 'users/login' =>  'users#login'

   get 'users/logout' => 'users#logout'
   get 'users/validation' => 'users#validation'
   get 'users/edit_profile/:id' => 'users#edit_profile'

   match '/cart_items', to: 'application#cart_items', via: :get
   get 'item/category' => 'home#items_category'


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
