# frozen_string_literal: true

require 'sidekiq-ent/web'


Rails.application.routes.draw do
  # Sessions
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout
  get '/login' => redirect('/auth/github'), as: :login

  # Sign up
  get '/start' => 'pages#start', as: :start
  get '/register' => 'users#registration', as: :register_form
  patch '/register' => 'users#register', as: :register

  # Users
  get '/profile' => 'users#show', as: :profile
  get '/profile/edit', to: 'users#edit'
  patch '/profile/edit', to: 'users#update'

  # Pages
  get '/details', to: 'pages#details'
  get '/events', to: 'pages#events'
  get '/eventkit', to: 'pages#event_kit', as: :event_kit
  get '/faq', to: 'pages#faqs'
  get '/thanks' => 'pages#thanks'
  get '/webinars', to: 'pages#webinars'

  # Sidekiq
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
    end
    mount Sidekiq::Web, at: "/sidekiq" unless ENV["SIDEKIQ_PASSWORD"].blank?
  else
    mount Sidekiq::Web, at: "/sidekiq"
  end

  # Diagnostics
  health_check_routes
  get '/boom', to: 'boom#show'
  unless Rails.env.production?
    get '/impersonate/:id', to: 'sessions#impersonate', as: :impersonate
  end

  # Default
  root to: 'pages#index'

  # Redirects
  get '/meetups' => redirect('/events')
end
