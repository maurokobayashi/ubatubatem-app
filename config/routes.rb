# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root 'landing_pages#index'

  # Profiles
  get 'profiles/index'
  get 'profiles/:id', to: 'profiles#show'
end
