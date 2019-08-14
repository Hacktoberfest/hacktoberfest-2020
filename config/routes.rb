# frozen_string_literal: true


Rails.application.routes.draw do
  root to: "home#index"
  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout" => "sessions#destroy", as: :logout
  get "/login" => redirect("/auth/github"), as: :login
end
