# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root "landing_pages#index"

  # Public content
  get "sobre-nos", to: "landing_pages#about_us", as: "about_us"

  # Bookmarks
  get "salvos", to: "bookmarks#index", as: "bookmarks"
  post "bookmarks", to: "bookmarks#create", as: "create_bookmark"
  delete "bookmarks", to: "bookmarks#destroy", as: "destroy_bookmark"

  # Catalogo
  get "buscar", to: "catalogo#search", as: "buscar"
  get "catalogo", to: "catalogo#index", as: "catalogo"
  get "categoria/:alias", to: "catalogo#catalogo_categoria", as: "catalogo_categoria"
  get "bairro/:alias", to: "catalogo#catalogo_bairro", as: "catalogo_bairro"

  # Features (profile)
  patch "features/:id", to: "features#update", as: "update_feature"

  # Profiles
  patch "profiles/:id", to: "profiles#update", as: "update_profile"
  patch "profiles/:id/avatar", to: "profiles#update_avatar", as: "update_profile_avatar"

  # Sessions
  get "entrar", to: "sessions#new", as: "signin"
  post "sessions", to: "sessions#create", as: "authenticate"
  get "sair", to: "sessions#destroy", as: "signout"

  # Statistics
  post "statistics", to: "statistics#track_profile", as: "track_statistic"

  # Users
  get "cadastrar", to: "users#new", as: "new_user"
  get "minha-conta", to: "users#edit", as: "edit_user"
  get "esqueci-senha", to: "users#password_forgot", as: "password_forgot"



  # Profile page - Must be the last one
  get ':username', to: "profiles#show", as: "profile", constraints: { username: /[^\/]+/ } # constraint: accept URLs with dot
  get ":username/editar", to: "profiles#edit", as: "edit_profile", constraints: { username: /[^\/]+/ }
  get ":username/reivindicar", to: "profiles#claim", as: "claim_profile", constraints: { username: /[^\/]+/ }
end
