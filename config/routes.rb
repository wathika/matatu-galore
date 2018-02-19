Rails.application.routes.draw do

  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':username/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  get 'notifications/:id/link_through', to: 'notifications#link_through', as: 'link_through'
  get 'notifications', to: 'notifications#index'

  get 'browse', to: 'posts#browse', as: 'browse_posts'

  devise_for :users
  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end

  get ':username', to: 'profiles#show', as: 'profile'
  get ':username/edit', to: 'profiles#edit', as: 'edit_profile'
  patch ':username/edit', to: 'profiles#update', as: 'update_profile'

  root to: "posts#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
