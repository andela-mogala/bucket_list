require 'api_constraints'

Rails.application.routes.draw do

  resources :users, only: [:create, :show, :update, :destroy]

  scope controller: :users do
    get '/signup' => :new, as: :signup
    post 'create' => :create
    get '/show' => :show
  end

  scope module: :api, defaults: { format: :json } do
    scope module: :v1 do
      constraints ApiConstraints.new(version: 1, default: true) do
        scope controller: :auth do
          post 'auth/login' => :login
          get 'auth/logout' => :logout
        end
        resources :bucketlists do
          resources :items
        end
      end
    end
  end
  match '*url', to: 'application#invalid_route', via: :all
end