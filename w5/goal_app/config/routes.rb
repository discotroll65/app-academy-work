Rails.application.routes.draw do
  root "goals#index"
  resource :session, only:[:new, :create, :destroy]
  resources :users, only:[:new, :create, :show, :index]
  resources :goals, only:[:new, :create, :edit, :update, :destroy]
end
