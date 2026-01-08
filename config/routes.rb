Rails.application.routes.draw do
  resources :audit_logs
  resources :api_logs
  resources :employees
  resources :products
  resources :categories
  resources :users

  get "/dashboard", to: "dashboard#index"
  post "/login", to: "auth#login"
  get "up" => "rails/health#show", as: :rails_health_check

end
