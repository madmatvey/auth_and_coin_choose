# frozen_string_literal: true

Rails.application.routes.draw do
  resources :currencies
  devise_for :users, :controllers => { :sessions => "bitupper_sessions" }
  resources :users
  resources :phones
  get '/phones/:id/confirm', to: 'phones#confirm', as: :confirm_phone

  authenticated :user do
    root 'users#show', as: :authenticated_root
  end
  root to: 'visitors#index'

  resources :after_signup

end
