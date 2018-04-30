Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'captures#index'
  resources :studios
  resources :animes
  resources :characters
  resources :captures

  resources :twitter do
    collection do
      get :timeline
      post :tweet
      get :replys
      post :reply
    end
  end
end
