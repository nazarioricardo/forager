Rails.application.routes.draw do
  get 'render/index'
  devise_for :user,
  controllers: {
     omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  get 'pages/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'dashboard', to: 'dashboard#show'
  # Jobs
  resources :jobs, only: [:new, :create, :show, :update, :edit] do
    get 'download', on: :member
  end
  # Resumes
  resources :resumes, only: [:new, :create, :show]

  # Letters
  resources :letters, only: [:new, :create, :show]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "render#index"
end
