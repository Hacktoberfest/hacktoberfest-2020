# frozen_string_literal: true

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
