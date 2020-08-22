Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :car_categories, :subsidiaries, :car_models
end
