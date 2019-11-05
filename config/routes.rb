# frozen_string_literal: true

if Hacktoberfest.sidekiq_enterprise_available?
  require 'sidekiq-ent/web'
else
  require 'sidekiq/web'
end

Rails.application.routes.draw do
  # Sessions
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/login', to: redirect('/auth/github'), as: :login

  # Sign up
  unless Hacktoberfest.ended?
    get '/start', to: 'pages#start', as: :start
    get '/register', to: 'users#registration', as: :register_form
    patch '/register', to: 'users#register', as: :register
  end

  # Users
  get '/profile', to: 'users#show', as: :profile
  get '/profile/edit', to: 'users#edit'
  patch '/profile/edit', to: 'users#update'

  # Pages
  get '/details', to: 'pages#details'
  get '/events', to: 'pages#events'
  get '/eventkit', to: 'pages#event_kit', as: :event_kit
  get '/faq', to: 'pages#faqs'
  get '/thanks', to: 'pages#thanks'
  get '/api-error', to: 'pages#api_error'
  get '/languages/projects(/:language_id)', to: 'languages#projects'
  get '/report', to: 'reports#new'
  post '/report', to: 'reports#create'

  # Sidekiq
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils
        .secure_compare(::Digest::SHA256.hexdigest(username),
                        ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
        ActiveSupport::SecurityUtils
        .secure_compare(::Digest::SHA256.hexdigest(password),
                        ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
    end
    mount Sidekiq::Web, at: '/sidekiq' if ENV['SIDEKIQ_PASSWORD'].present?
  else
    mount Sidekiq::Web, at: '/sidekiq'
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
  get '/meetups', to: redirect('/events')
end
