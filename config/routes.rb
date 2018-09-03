Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :analyzed_sites, only: [:create, :show]
      resources :users, only: [:create]
    end
  end
end
