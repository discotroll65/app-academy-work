Links::Application.routes.draw do
  get '/home' => 'static_pages#home'

  get '/about' => 'static_pages#about'

  get '/contact' => 'static_pages#contact'

  root "links#index"
  resource :session
  resources :users
  resources :links
end
