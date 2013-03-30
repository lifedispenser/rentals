source 'https://rubygems.org'
#source 'http://production.cf.rubygems.org'

gem 'rails',     github: 'rails/rails'
gem 'arel',      github: 'rails/arel'
#gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'

gem 'pg'
gem 'devise', github: 'plataformatec/devise', branch: 'rails4'

# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails',   github: 'rails/sass-rails'
gem 'bootstrap-sass'

group :assets do
#  gem 'sprockets-rails', github: 'rails/sprockets-rails'

 # Use the following until https://github.com/rails/sprockets-rails/pull/36 is merged
  gem 'sprockets-rails', github: 'onomojo/sprockets-rails'
#  gem 'sprockets-rails', path: '../sprockets-rails'

  gem 'coffee-rails', github: 'rails/coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'paperclip', github: 'thoughtbot/paperclip'
gem 'haml', github: 'haml/haml'
gem 'jquery-rails', github: 'rails/jquery-rails'
gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
gem 'jquery-fileupload-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'will_paginate'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

gem 'aws-sdk', github: 'aws/aws-sdk-ruby'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
group :development do
  gem 'capistrano'
  gem 'rvm-capistrano'
end

# To use debugger
# gem 'debugger'

group :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'minitest-rails'
  gem 'minitest-rails-shoulda'
  gem 'minitest-matchers'
  gem 'minitest-rg'
  gem 'minitest-rails-capybara'
  gem 'minitest-metadata'
  gem 'capybara_minitest_spec'
  gem 'capybara-webkit'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
end