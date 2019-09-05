source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.5.1'

gem 'airrecord'

gem 'analytics-ruby', '~> 2.0.0', require: 'segment/analytics'

gem 'bootsnap', '>= 1.1.0', require: false

gem 'coffee-rails', '~> 4.2'

gem 'faraday'
gem 'faraday-http-cache'

gem 'jbuilder', '~> 2.5'

gem 'kramdown'

# Must be locked before version 3.0 for use with airrecord gems
# See: https://github.com/sirupsen/airrecord/issues/63
gem 'net-http-persistent', '~> 2.9'

gem 'omniauth-github'

gem 'puma', '~> 3.11'

gem 'rails', '~> 5.2.3'

gem 'sass-rails', '~> 5.0'

gem 'state_machines'

gem 'state_machines-activerecord'

gem 'sqlite3'

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

  gem 'vcr'

  gem 'webmock'
end

group :development do

  gem 'guard-rspec', require: false

  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'octokit'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'terminal-notifier-guard'

  gem 'web-console', '>= 3.3.0'
end
