Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  root 'welcome#index'

  resources :questions do
    resources :answers do
      member do
        patch :mark
      end
    end
  end

end
