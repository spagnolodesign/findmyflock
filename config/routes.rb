Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations]
  devise_for :developers

  root 'pages#home'
  get "/pages/:page", to: "pages#show", as: :pages


  authenticate :admin do
    namespace :admin do
      get 'dashboard/index'
    end
  end
end
