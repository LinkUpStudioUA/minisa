source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'active_model_serializers', '~> 0.10.0'
gem 'apitome'
gem 'bcrypt'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'dry-transaction'
# gem 'dry-monads'
gem 'enumerize'
gem 'factory_bot_rails'
gem 'image_processing'
gem 'kaminari'
gem 'knock'
gem 'mini_magick', '>= 4.3.5'
gem 'money-rails', '~>1.12'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'pundit'
gem 'rack-reducer', require: 'rack/reducer'
gem 'rails', '~> 5.2.3'
gem 'rails_admin', '~> 2.0.0.beta'
gem 'rspec_api_documentation'
gem 'sidekiq'
gem 'shrine-memory'
gem 'shrine', '~> 2.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
