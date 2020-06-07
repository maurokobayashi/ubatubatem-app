# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root "landing_pages#index"

  # Sessions
  get "entrar", to: "sessions#new", as: "signin"
  post "create", to: "sessions#create", as: "authenticate"
  get "sair", to: "sessions#destroy", as: "signout"

  # Catalogo
  get "buscar", to: "catalogo#search", as: "buscar"
  get "catalogo", to: "catalogo#index", as: "catalogo"
  get "categoria/:alias", to: "catalogo#catalogo_categoria", as: "catalogo_categoria"
  get "bairro/:alias", to: "catalogo#catalogo_bairro", as: "catalogo_bairro"

  # Bookmarks
  get "salvos", to: "bookmarks#index", as: "bookmarks"


  # Statistics
  post "statistics", to: "statistics#track_profile", as:"track_statistic"





  # Profile page - Must be the last one
  get ':username', to: "profiles#show", as: "profile", constraints: { username: /[^\/]+/ } # constraint: accept URLs with dot
end
