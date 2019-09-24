# frozen_string_literal: true

require 'sidekiq/web'


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
  get '/event-kit', to: 'pages#event_kit', as: :event_kit
  get '/start' => 'pages#start', as: :start
  get '/thanks' => 'pages#thanks'
  get '/boom', to: 'boom#show'

  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
    end 
    mount Sidekiq::Web, at: "/sidekiq" unless ENV["SIDEKIQ_PASSWORD"].blank?
  else
    mount Sidekiq::Web, at: "/sidekiq"
  end

  health_check_routes

  unless Rails.env.production?
    get '/impersonate/:id', to: 'sessions#impersonate', as: :impersonate
  end
end
