source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'daemons', '~> 1.3', '>= 1.3.1'
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.3'
gem 'devise', '~> 4.6', '>= 4.6.2'
gem 'devise_token_auth', '~> 1.1'
gem 'geocoder', '~> 1.5', '>= 1.5.1'
gem 'jbuilder', '~> 2.9', '>= 2.9.1'
gem 'one_signal', '~> 1.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'byebug', '~> 11.0', '>= 11.0.1'
  gem 'factory_bot_rails', '~> 5.0', '>= 5.0.2'
  gem 'faker', '~> 1.9', '>= 1.9.6'
  gem 'rails_best_practices', '~> 1.19', '>= 1.19.4'
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  gem 'shoulda-matchers', '~> 4.1'
end

group :development do
  gem 'annotate', '~> 2.7', '>= 2.7.5'
  gem 'letter_opener', '~> 1.7'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'reek', '~> 5.4'
  gem 'rubocop', '~> 0.72.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
