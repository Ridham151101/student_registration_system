Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  resources :users do
    collection { post :import }
    collection { get :export }
    member do
      patch :verify_student
    end
  end

  post '/student_registration', to: 'users#student_registration'

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'

  root to: "home#index"
end
