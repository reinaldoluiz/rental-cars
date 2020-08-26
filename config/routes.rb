Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'rentals/search', to: 'rentals#search'
  resources :car_categories, :subsidiaries, :car_models, :rentals
  
end
