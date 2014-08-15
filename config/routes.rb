Rails.application.routes.draw do

  root "houses#index"

  resources :houses

  resources :users do
    #this resource depends on a user
  	resources :houses
    
  end

  resource :session, only: [:new, :create, :destroy]
  resources :orders

end
