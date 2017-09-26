Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  root 'top#index'

  # twitter login
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
    resources :videos, only: %i( index show destroy )
    resources :daily_photos, only: %i( index )
  end
  resource :photos, only: %i( new create )
  resource :photo_search, only: %i( create )
  resource :photo_geo_search, only: %i( create )
  resources :shared_albums, only: %i( show create )
  ## user関連
  resources :users, only: %i( index show new create edit update destroy )
  resources :user_searches, only: %i( create )

  # api
  namespace :api do
    resources :photos, only: %i( index show create update destroy )
    resources :shared_albums, only: %i( show )
    resources :informations, only: %i( index )
  end

  # admin
  # namespace :admin, constraints: WhitelistConstraints.new do
  namespace :admin do
    get '/' => 'top#index'
    resources :informations, only: %i( index show new create edit update destroy )
    resources :users, only: %i( index show new create edit update destroy )
    resources :photos, only: %i( index show new create edit update destroy )
  end

  # ===============================================================================
  # mount Famiphotos
  # ===============================================================================
  mount FamiphotosPlatform::Engine, at: '/'
end
