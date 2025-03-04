# frozen_string_literal: true

Rails.application.routes.draw do
  resources :cnabs
  resources :transactions
  resources :stores
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "cnabs#index"
end
