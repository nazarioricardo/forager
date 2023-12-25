Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")
  root 'pages#index'
  get 'pages/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'dashboard', to: 'dashboard#show'
  # Jobs
  resources :jobs, only: [:new, :create, :show, :update]

  # Resumes
  resources :resumes, only: [:new, :create, :show]

  # Letters
  resources :letters, only: [:new, :create, :show]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
