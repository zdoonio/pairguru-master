Rails.application.routes.draw do
  get '/hall_of_fame', to: 'fame#index', as: 'fame_path'
  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    resources :comments
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
end
