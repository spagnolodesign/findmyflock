Rails.application.routes.draw do

  get 'skills/create'
  get 'skills/destroy'
  devise_for :admins, skip: [:registrations], path: 'admins'
  devise_for :developers, path: 'developers'

  root 'pages#home'
  get "/pages/:page", to: "pages#show", as: :pages

  authenticate :admin do
    namespace :admin do
      root 'dashboard#index'
      resources :competences
      resources :benefits
      resources :cultures
      resources :companies
      resources :jobs do
        resources :skills, only: [:create, :destroy]
      end
      resources :developers do
        resources :skills, only: [:create, :destroy]
      end
    end
  end
end
