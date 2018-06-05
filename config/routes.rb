Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations], path: 'admins'
  devise_for :developers, path: 'developers'

  root 'pages#home'
  get "/pages/:page", to: "pages#show", as: :pages

  authenticate :admin do
    namespace :admin do
      root 'dashboard#index'
    end
  end
end
