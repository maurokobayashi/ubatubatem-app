# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root "landing_pages#index"

  # Bookmarks
  get "salvos", to: "bookmarks#index", as: "bookmarks"
  post "bookmarks", to: "bookmarks#create", as: "create_bookmark"
  delete "bookmarks", to: "bookmarks#destroy", as: "destroy_bookmark"

  # Catalogo
  get "buscar", to: "catalogo#search", as: "buscar"
  get "explorar", to: "catalogo#explore", as: "explorar"
  get "catalogo", to: "catalogo#index", as: "catalogo"
  get "categoria/:alias", to: "catalogo#catalogo_categoria", as: "catalogo_categoria"
  get "bairro/:alias", to: "catalogo#catalogo_bairro", as: "catalogo_bairro"

  # Features (profile)
  patch "features/:id", to: "features#update", as: "update_feature"

  # Profiles
  get "profiles/:id/edit", to: "profiles#edit", as: "edit_profile"
  patch "profiles/:id", to: "profiles#update", as: "update_profile"

  # Sessions
  get "entrar", to: "sessions#new", as: "signin"
  post "sessions", to: "sessions#create", as: "authenticate"
  get "sair", to: "sessions#destroy", as: "signout"

  # Statistics
  post "statistics", to: "statistics#track_profile", as: "track_statistic"

  # Users
  get "cadastrar", to: "users#new", as: "new_user"
  get "senha", to: "users#password_forgot", as: "password_forgot"



  # Profile page - Must be the last one
  get ':username', to: "profiles#show", as: "profile", constraints: { username: /[^\/]+/ } # constraint: accept URLs with dot
end
