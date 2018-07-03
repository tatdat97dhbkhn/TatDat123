Rails.application.routes.draw do
  resources :users
  scope "(:locale)", :locale => /en|vi/ do
    root "static_pages#home"
    get "/signup", to: "users#new"
    get "/show", to: "users#show"
    post "/signup", to: "users#create"
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
  end
end
