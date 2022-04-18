Rails.application.routes.draw do
  root "orders#index"
  resources :menus
  get "/orders/daily-report", to: "orders#daily_report"
  resources :orders
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
