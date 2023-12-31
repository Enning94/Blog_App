Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
root "users#index"

resources :users, only: [:index, :show] do
  resources :posts, only: [:index, :show, :new, :create, :destroy] do
    resources :comments, only: [:create, :new, :destroy] 
    resources :likes, only: [:create, :destroy] 

end
end

# API endpoints

namespace :api do
  namespace :v1 do
    resources :users, only: [:index, :create, :update, :destroy, :show] do
      resources :posts, only: [:index, :create, :update, :destroy, :show] do
        resources :comments, only: [:index, :show, :create]
        resources :likes, only: [:index, :show]
      end
    end
  end
end
end


