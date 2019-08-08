Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  post 'user_token' => 'user_token#create'

  resources :users, only: %i[create show update]
  resources :sellers, only: %i[index show]

  resources :services, only: %i[index show create update destroy]

  resources :service_requests, only: %i[show create] do
    member do
      patch :submit
      patch :deny
      patch :cancel
    end

    resources :service_answers, only: %i[create]
  end
end
