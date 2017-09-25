Rails.application.routes.draw do
  resources :studios
  resources :animes
  resources :characters
  resources :pictures do
    member do
      get :character_for_form
    end
  end
  root 'pictures#index'
end
