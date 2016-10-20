Rails.application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"

  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: [:create, :show, :update]
    end
  end
end
