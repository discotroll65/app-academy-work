Rails.application.routes.draw do
  root 'bands#index'
  resource :user, only:[:new, :create, :show]
  resource :session, only:[:new, :create, :destroy]

  resources :bands do
    resources :albums, only:[:index, :new]
  end

  resources :albums, except:[:index, :new] do
    resources :tracks, only:[:index, :new]
  end

  resources :tracks, except:[:index, :new]
  resources :notes, only:[:create, :destroy]
end
