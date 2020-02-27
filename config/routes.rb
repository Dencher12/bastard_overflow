Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  root 'welcome#index'

  resources :attachments, only: %i[destroy]

  resources :questions do
    resources :answers do
      member { patch :mark }
      member { patch :rate_up }
      member { patch :rate_down }
    end
  end

  mount ActionCable.server => '/cable'
end
