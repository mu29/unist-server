Rails.application.routes.draw do
  resources :sessions, only: [:create, :destroy]
  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :articles do
    resources :comments
  end
end
