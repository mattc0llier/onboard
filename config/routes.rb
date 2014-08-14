Rails.application.routes.draw do
  root "house#index"

  resources :houses
end
