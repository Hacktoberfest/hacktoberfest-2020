Rails.application.routes.draw do

  root to: "home#index"
  get "/auth/:provider/callback", to: "sessions#create"
    get "/login" => redirect("/auth/github"), as: :login
    get "/logout" => "sessions#destroy", as: :logout
end
