Rails.application.routes.draw do
  devise_for :users
  root 'captures#index'
  resources :captures
  resources :studios
  resources :animes
  resources :characters
end
