# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root 'landing_pages#index'

  # Profiles
  get 'profiles/:id', to: 'profiles#show', as: 'profile'
  get 'buscar', to: 'profiles#search'
  get 'autocomplete', to: 'profiles#autocomplete'

  # Statistics
  post 'statistics', to: 'statistics#track_profile', as:'track_statistic'
end
