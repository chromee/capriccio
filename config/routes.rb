Rails.application.routes.draw do
  resources :studios
  resources :animes
  resources :characters
  resources :pictures
  root 'pictures#index'
end
