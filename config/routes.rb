Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: [:create, :show, :update, :destroy]
      resources :bucketlists do
        resources :items
      end
    end
  end
end
