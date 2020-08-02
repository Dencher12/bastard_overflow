require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  root 'welcome#index'

  resources :attachments, only: %i[destroy]

  resources :questions do
    resources :comments
    resources :answers do
      resources :comments
      member { patch :mark }
      member { patch :rate_up }
      member { patch :rate_down }
    end
  end

  mount ActionCable.server => '/cable'
end
