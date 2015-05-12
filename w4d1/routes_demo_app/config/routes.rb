Rails.application.routes.draw do
  resources :contacts, only: [:create, :show, :update, :destroy]
  resources :contact_shares, only: [:create, :destroy]

  resources :users do
    resources :contacts, only: [:index]
  end
end
#   get '/users' => 'users#index'
#   post '/users' => 'users#create'
#   get 'users/new' => 'users#new', :as => 'new_user'
#   get 'users/:id/edit' => 'users#edit', as: 'edit_user'
#   get 'users/:id' => 'users#show', as: 'user'
#   patch 'users/:id' => 'users#update'
#   put 'users/:id' => 'users#update'
#   delete 'users/:id' => 'users#destroy'
