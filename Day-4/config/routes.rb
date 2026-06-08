Rails.application.routes.draw do
  # Authentication
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  # Registration
  get  "/register", to: "users#new"
  post "/register", to: "users#create"

  # Articles
  resources :articles do
    member do
      post :report  # POST /articles/:id/report
    end
  end

  root "articles#index"
end
