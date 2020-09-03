Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'rentals/search', to: 'rentals#search'
  resources :car_categories, :subsidiaries, :car_models
  resources :rentals, only:[:index, :show, :new, :create] do 
    resources :car_rentals, only: [:new, :create]
    get 'search', on: :collection
  end
end
