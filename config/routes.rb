# frozen_string_literal: true

require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
end if Rails.env.production?
mount Sidekiq::Web, at: "/sidekiq"

Rails.application.routes.draw do
  root to: 'pages#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout
  get '/login' => redirect('/auth/github'), as: :login
  get '/profile' => 'users#show', as: :profile
  get '/register' => 'users#edit', as: :register_form
  patch '/register' => 'users#update', as: :register
  get '/faq', to: 'pages#faqs'
  get '/meetups', to: 'pages#meetups'
  get '/webinars', to: 'pages#webinars'
  get '/details', to: 'pages#details'
end
