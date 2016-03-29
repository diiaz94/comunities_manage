Rails.application.routes.draw do
  resources :requests

  resources :status_requests

  resources :type_requests

  resources :parishes

  resources :towns

  resources :states

  resources :jobs

  resources :profiles

  resources :members

  resources :families

  resources :comunities

  resources :types

  resources :users
  resources :usuario_sessions

  get 'login' => 'usuario_sessions#new', as: :login
  get 'logout' => 'usuario_sessions#destroy', as: :logout
  post 'culminate' => 'usuario_sessions#culminate_login', as: :culminate
  get 'particles/:id' => 'profiles#set_particles_profiles', as: :particles
  get 'buscar' => 'searches', as: :buscar
  post 'create_admin_profile' => 'welcome#create_admin_profile', as: :create_admin_profile
  post 'create_admin_user' => 'welcome#create_admin_user', as: :create_admin_user
  get 'admin_profile' => 'welcome#admin_profile', as: :admin_profile
  get 'admin_user' => 'welcome#admin_user', as: :admin_user
  get 'my_profile' => 'profiles#my_profile', as: :my_profile
  get 'my_comunity' => 'comunities#my_comunity', as: :my_comunity
  get 'my_comunity/edit' => 'comunities#my_comunity_edit', as: :my_comunity_edit
  get 'register' => 'users#new', as: :register
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
