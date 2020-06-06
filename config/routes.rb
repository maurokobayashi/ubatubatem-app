# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root "landing_pages#index"

  # Sessions
  get "entrar", to: "sessions#new", as: "new_session"
  post "create", to: "sessions#create", as: "signin"
  get "sair", to: "sessions#destroy", as: "signout"

  # Profiles
  get "profiles/:id", to: "profiles#show"
  get "buscar", to: "profiles#search", as: "buscar"
  get "catalogo", to: "profiles#catalogo", as: "catalogo"
  get "categoria/:alias", to: "profiles#catalogo_categoria", as: "catalogo_categoria"
  get "bairro/:alias", to: "profiles#catalogo_bairro", as: "catalogo_bairro"

  # Statistics
  post "statistics", to: "statistics#track_profile", as:"track_statistic"





  # Must be the last one
  get ':username', to: "profiles#show", as: "profile", constraints: { username: /[^\/]+/ } # constraint: accept URLs with dot
end
