Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: [:create, :show, :update, :destroy] do
        resources :bucketlists, only: [:create, :update, :destroy]
      end
      resources :bucketlists, only: [:index, :show]
    end
  end
end
