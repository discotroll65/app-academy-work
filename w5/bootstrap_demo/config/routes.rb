Links::Application.routes.draw do
  root "links#index"
  resource :session
  resources :users
  resources :links
end
