Rails.application.routes.draw do
  root "subs#index"
  resource :user, only: [:new, :create, :show]
  resource :session, only: [:create, :new, :destroy]
  resources :subs, except: [:destroy]



end
