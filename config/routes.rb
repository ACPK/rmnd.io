Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, only: [:create]
  resources :users, only: Clearance.configuration.user_actions do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    get "email_confirmations/:token",
      to: "email_confirmations#update",
      as: :email_confirmation
  end
  resource :user, only: [:edit, :update]
  resources :reminders, only: [:index, :create, :edit, :update] do
    resource :cancellation, only: [:create]
  end
  get "/sign_in", to: "sessions#new", as: "sign_in"
  delete "/sign_out", to: "sessions#destroy", as: "sign_out"
  get "/sign_up", to: "users#new", as: "sign_up"
  post "/emails", to: "griddler/emails#create"
  root to: "home_pages#show"
end
