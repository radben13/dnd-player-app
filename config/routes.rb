Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'
  
  resources :players do
    resources :characters
    member do
      get 'activate'
    end
  end
  
  resources :items do
    collection do
      get 'list'
    end
  end
  
  get  'account' => 'players#show'
  get  'api/player' => 'players#show_json'
  post 'login' => 'player_sessions#create', as: :new_session
  get  'login' => 'player_sessions#new', as: :login
  get  'logout' => 'player_sessions#delete'
  get  'players/:id/reset_password/:auth_token' => 'players#new_password'
  post 'players/:id/reset_password' => 'players#reset_password'
  
  post 'email_reset_password' => 'players#request_password', as: :send_password_email
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
