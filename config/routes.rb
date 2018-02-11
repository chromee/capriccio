Rails.application.routes.draw do
  resources :studios
  resources :animes
  resources :characters
  resources :captures
  root 'captures#index'
end
