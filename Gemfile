source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use Puma as the app server
gem 'hiredis'
gem 'redis', require: ['redis', 'redis/connection/hiredis']
gem 'rack-cors'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 4.1'
# スキーマ管理
gem 'ridgepole'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platform: :mri
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # コーディング規約チェック
  gem 'rubocop'
  gem 'onkcop'
  # テスト、コードチェックを自動で別プロセスでやる
  # gem 'guard', '~> 2.8'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'terminal-notifier-guard'
  gem "pry-rails"
  gem 'pry-byebug'
  gem 'test-queue'
  # 環境変数をセット
  gem 'dotenv-rails'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code
  gem 'web-console', '~> 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # mail test
  gem 'letter_opener'
  # 静的解析
  gem "rubycritic", :require => false
  gem 'pre-commit'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'
  # rakeのテスト用
  gem 'rake_shared_context'
  gem 'factory_bot_rails'
  gem 'database_rewinder'
  gem 'shoulda-matchers'
  # コードカバレッジ
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'request_store'

  # 良い書き方しているかチェック
  gem 'rails_best_practices'

  gem 'rb-readline'
  # プロファイリング
  # gem 'stackprof'
  # gem 'stackprof-webnav'
  # 静的解析
  gem 'brakeman', require: false
end

# 本番環境のみ適用
group :production do
  gem 'cloudinary'
  gem 'bonsai-elasticsearch-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# 認証
gem 'omniauth-twitter'
# バッチ処理
gem 'whenever',  :require => false

# template engine
gem "slim-rails"
# TODOのやつだったかな？
gem "watson-ruby"
# Apiのバージョン管理
gem "versioncake"
# decorator
gem "active_decorator"
# 画像変換
gem 'mini_magick'
# 画像ライブラリ
gem 'rmagick'
# 位置情報
gem 'geocoder'
# 権限チェック
gem "pundit"

# breadcrumbs
gem "crummy",  "~> 1.8.0"
# elasticsearch
gem 'elasticsearch-rails'
gem 'elasticsearch-model'
# enumerize
gem 'enumerize'

# ログ収集
gem "ltsv-logger"
gem "font-awesome-rails"
# ブラウザ判定、UA判定に使う
gem 'browser'
gem 'parser'
# 擬似的なテーブルのように使える
gem 'active_hash'
# pagenate
gem 'kaminari'
# 暗号化
gem 'attr_encrypted'
# assets 高速化
# gem 'sprockets-derailleur'
# SQL発行場所を出力させる
gem 'activerecord-cause'
# プロセス管理
gem 'foreman'
