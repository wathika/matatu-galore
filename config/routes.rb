Rails.application.routes.draw do

  devise_for :users
  resources :posts do
    resources :comments
  end

  get ':username', to: 'profiles#show', as: 'profile'
  get ':username/edit', to: 'profiles#edit', as: 'edit_profile'
  patch ':username/edit', to: 'profiles#update', as: 'update_profile'

  root to: "posts#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
