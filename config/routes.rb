require 'api_constraints_service'

Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1,
      constraints: ApiConstraintsService(version: 2, default: true) do
      scope controller: :auth do
        post 'auth/login' => :login
      end
      resources :users, only: [:create, :show, :update, :destroy]
      resources :bucketlists do
        resources :items
      end
    end
  end
end
