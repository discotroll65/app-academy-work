Rails.application.routes.draw do
  root "subs#index"
  resource :user, only: [:new, :create, :show]
  resource :session, only: [:create, :new, :destroy]
  resources :subs, except: [:destroy] do
    resources :posts, only: [:new, :show]
  end
  resources :posts, except: [:new, :index, :show] do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:create]
end
