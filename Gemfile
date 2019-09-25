source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.5.5'

gem 'airbrake', '~> 9.4'

gem 'airrecord'

gem 'bootsnap', '>= 1.1.0', require: false
gem "bulma-rails", "~> 0.7.5"

gem 'coffee-rails', '~> 4.2'

gem 'dalli', '~> 2.7'

gem 'faraday'
gem 'faraday_middleware'

gem "health_check"

gem 'jbuilder', '~> 2.5'

gem 'kramdown'

# Must be locked before version 3.0 for use with airrecord gems
# See: https://github.com/sirupsen/airrecord/issues/63
gem 'net-http-persistent', '~> 2.9'

gem 'octokit'
gem 'omniauth-github'

gem 'puma', '~> 4.0'

gem 'rails', '~> 5.2.3'

gem 'sass-rails', '~> 5.0'
gem 'sidekiq', '< 6.0'

source "https://enterprise.contribsys.com/" do
  gem 'sidekiq-pro'
  gem 'sidekiq-ent'
end

gem 'state_machines'

gem 'state_machines-activerecord'

gem 'pg'

gem 'pry'

gem 'turbolinks', '~> 5'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'dotenv-rails'

  gem 'factory_bot_rails'

  gem 'rspec-rails'

  gem 'rubocop-rails'

  gem 'shoulda-matchers'

  gem 'vcr'

  gem 'webmock'
end

group :development do
  gem "capistrano", "~> 3.11", require: false
  gem 'capistrano-bundler', '~> 1.6', require: false
  gem 'capistrano-dotenv', require: false
  gem "capistrano-rails", "~> 1.4", require: false
  gem 'capistrano3-puma', "~> 4.0", require: false
  gem 'capistrano-sidekiq', require: false

  gem 'guard-rspec', require: false

  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'terminal-notifier-guard'

  gem 'web-console', '>= 3.3.0'
end
