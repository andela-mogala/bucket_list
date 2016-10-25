require 'api_constraints'

Rails.application.routes.draw do

  scope module: :api, defaults: { format: :json } do
    scope module: :v1 do
      constraints ApiConstraints.new(version: 1, default: true) do
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
end