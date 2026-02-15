Rails.application.routes.draw do
  devise_for :users,
    defaults: { format: :json },
    path: '',
    path_names: {
      sign_in: 'auth/login',
      sign_out: 'auth/logout'
    },
    controllers: { sessions: 'auth/sessions' }

  get 'auth/me', to: 'auth/me#show'

  get "up" => "rails/health#show", as: :rails_health_check

  resources :jobs
  
  # Defines the root path route ("/")
  # root "posts#index"
end
