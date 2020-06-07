# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root "landing_pages#index"

  # Sessions
  get "entrar", to: "sessions#new", as: "signin"
  post "create", to: "sessions#create", as: "authenticate"
  get "sair", to: "sessions#destroy", as: "signout"

  # Profiles
  get "buscar", to: "profiles#search", as: "buscar"

  get "catalogo", to: "profiles#catalogo", as: "catalogo"
  get "categoria/:alias", to: "profiles#catalogo_categoria", as: "catalogo_categoria"
  get "bairro/:alias", to: "profiles#catalogo_bairro", as: "catalogo_bairro"

  get "salvos", to: "profiles#salvos", as: "salvos"


  # Statistics
  post "statistics", to: "statistics#track_profile", as:"track_statistic"





  # Profile page - Must be the last one
  get ':username', to: "profiles#show", as: "profile", constraints: { username: /[^\/]+/ } # constraint: accept URLs with dot
end
