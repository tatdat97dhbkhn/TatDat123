Rails.application.routes.draw do
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  scope "(:locale)", :locale => /en|vi/ do
    root "static_pages#home"
    get "/signup", to: "users#new"
    get "/show", to: "users#show"
    get "/users", to: "users#index"
    post "/signup", to: "users#create"
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/login", to: "session#new"
    post "/login", to: "session#create"
    delete "/logout", to: "session#destroy"
  end
end
