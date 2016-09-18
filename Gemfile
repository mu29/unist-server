source 'https://rubygems.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# 앱 서버
gem 'puma', '~> 3.0'
# JSON API
gem 'jbuilder', '~> 2.5'
# 비밀번호 암호화
gem 'bcrypt', '~> 3.1.7'
# 데이터베이스는 mariadb
gem 'mysql2'
# JSON Web Token
gem 'jwt'
# model-controller 를 이어주는 인터렉터
gem 'interactor'
gem 'interactor-rails'
# 권한
gem 'authority'
# 페이지네이션
gem 'kaminari'
# 태그
gem 'acts-as-taggable-on'
# 콘솔 프린트
gem 'awesome_print'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
group :development, :test do
  gem 'byebug', platform: :mri

  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop'
end

gem 'codeclimate-test-reporter', group: :test, require: nil

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
