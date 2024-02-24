Rails.application.routes.draw do
  get 'render/index'
  devise_for :users,
  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions' 
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  get 'pages/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'dashboard', to: 'dashboard#show'
  
  # Jobs
  resources :jobs, only: [:new, :create, :show, :update, :edit] do
    get 'download', on: :member
    put 'update_status', on: :member
  end

  # Resumes
  resources :resumes, only: [:new, :create, :show]
  resources :resumes do
    get 'download', on: :member
  end

  # Letters
  resources :letters, only: [:new, :create, :show]
  resources :letters do
    get 'download', on: :member
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "render#index"
end
