source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.3'
gem 'mysql2', '0.4.10'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'

# html
gem 'slim'
gem 'slim-rails'
# css
gem 'sass-globbing'
gem 'bootstrap', '~> 4.1.0'
gem 'bootstrap_form'
gem 'bootstrap_tagsinput_rails'
# js
gem 'jquery-rails'
gem "jquery-turbolinks"

# いつも使う
gem 'devise'
gem 'cancancan'
gem 'rolify'
gem 'annotate'
gem 'kaminari', '~> 0.17.0'
gem 'active_hash'

# たまに使う
gem 'acts-as-taggable-on', '~> 5.0'

# 画像系
gem 'paperclip'
gem 'ruby-opencv'

# twitter認証
gem 'twitter'
gem 'omniauth'
gem 'omniauth-twitter'

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
