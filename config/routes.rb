Rails.application.routes.draw do
  # api 認証用のroutes
  use_doorkeeper
  root 'top#index'

  # facebook login
  get "/:provider/login"  => "sessions#new"
  get "/logout" => "sessions#destroy"
  get "/auth/:provider/callback" => "sessions#create" unless Rails.env.development?
  post "/auth/:provider/callback" => "sessions#create" if Rails.env.development?
  get "/auth/failure" => "sessions#failuer"

  # web
  ## アルバム関連
  resources :albums, only: %i( index show new create edit update destroy ) do
    ## 写真関連
    resources :photos, only: %i( index show destroy )
  end
  resource :photo, only: %i( new create )
  resource  :photo_search, only: %i( create )
  resource  :photo_geo_search, only: %i( create )
  ## user関連
  resources :users, only: %i( index show new create edit update destroy )
  resources :user_searches, only: %i( create )

  # api
  namespace :api do
    resources :photos, only: %i( index show create update destroy )
    resources :informations, only: %i( index )
  end

  # admin
  # namespace :admin, constraints: WhitelistConstraints.new do
  namespace :admin do
    get '/' => 'top#index'
    resources :informations, only: %i( index show new create edit update destroy )
  end

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
