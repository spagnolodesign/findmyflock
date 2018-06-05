Rails.application.routes.draw do
  devise_for :developers

  root 'pages#home'
  get "/pages/:page", to: "pages#show", as: :pages


end
