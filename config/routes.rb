Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :studios
  resources :animes
  resources :characters
  resources :captures
  root 'captures#index'
end
