Rails.application.routes.draw do
  root "products#index"

  resources :products

  resource :session
end
