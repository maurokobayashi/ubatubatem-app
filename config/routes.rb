# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root "landing_pages#index"

  # Sessions
  get "entrar", to: "sessions#new", as: "new_session"
  post "create", to: "sessions#create", as: "signin"
  get "sair", to: "sessions#destroy", as: "signout"

  # Profiles - TODO: /username
  get "profiles/:id", to: "profiles#show", as: "profile"
  # TODO: /marcante.paes
  get "buscar", to: "profiles#search"
  # get "buscar_full", to: "profiles#fullsearch"

  # Categs
  get "cat/:alias", to: "categs#show", as: "categoria"
  get "categorias", to: "categs#index", as: "categorias"

  # Statistics
  post "statistics", to: "statistics#track_profile", as:"track_statistic"
end
