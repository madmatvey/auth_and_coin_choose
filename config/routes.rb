Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :phones
  get '/phones/:id/confirm', to: 'phones#confirm', :as => :confirm_phone
  # put '/phones/:id/' => 'phones#update'
end
