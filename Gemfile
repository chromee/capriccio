source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.5'
gem 'mysql2'
gem 'puma', '~> 3.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# JS系
gem 'coffee-rails', '~> 4.2'
gem 'coffee-script-source', '1.8.0'
gem 'jquery-rails'
gem "jquery-turbolinks"

# css系
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
gem 'bootstrap-tagsinput-rails'
gem 'twitter-bootstrap-rails'

# rails系
gem 'acts-as-taggable-on'
gem 'paperclip'
gem 'kaminari', '~> 0.17.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
