source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.2'
# Use mysql as the database for Active Record
gem 'mysql2', ' ~> 0.3.18'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development
gem 'binding_of_caller'

# responders gem
gem 'responders', '~> 2.0'

# db schema関連
gem 'ridgepole'
gem 'activerecord-mysql-awesome'

# 認証
gem 'omniauth-twitter'
# バッチ処理
gem 'whenever'

# テスト関連
group :test do
  gem 'rspec-rails'
  gem 'rspec-mocks'
  # rakeのテスト用
  gem 'rake_shared_context'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'database_rewinder'
  gem 'rspec-request_describer'

  # コードカバレッジ
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false

  gem 'coveralls', require: false
  gem 'request_store'

  # コーディング規約チェック
  gem 'rubocop', '~> 0.23',  require: false
  gem 'rubocop-checkstyle_formatter', require: false
  # 良い書き方しているかチェック
  gem 'rails_best_practices'

  gem "byebug"
  # gem "nio4r", "0.5.0"
  gem "rake-compiler"
  # webテスト
  gem 'capybara'
  # プロファイリング
  # gem 'stackprof'
  # gem 'stackprof-webnav'

  # 静的解析
  # gem 'rubycritic', require: false
  gem 'brakeman', require: false
end

# 開発, テスト時に使うツール群
group :development, :test do
  # テスト、コードチェックを自動で別プロセスでやる
  # gem 'guard', '~> 2.8'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'terminal-notifier-guard'
  gem "pry-rails"
  gem "pry-doc"
  gem 'pry-byebug'
  gem 'test-queue'
  # バグの起こりやすい箇所を数値化
  gem 'bugspots'
  # 環境変数をセット
  gem 'dotenv-rails'
end

# 開発時に使うツール群
group :development do
  gem "awesome_print"
  gem "better_errors"
  gem "quiet_assets"
  gem "did_you_mean"
  gem 'web-console', '~> 2.0'
end
# template engine
gem "slim-rails"
# TODOのやつだったかな？
gem "watson-ruby"
# キャッシュ
gem "cache_digests"
# Apiのバージョン管理
gem "versioncake"
# decorator
gem "active_decorator"
# 画像アップロード
gem "paperclip"
# 権限チェック
gem "pundit"
# fontのライブラリ
gem "font-awesome-rails"
# javascriptとRubyの連携
gem "gon"
# 本番だけ使うもの
group :production do
  gem "foreman"
  gem "rails_12factor"
  gem "puma"
  gem "newrelic_rpm"
end
# heroku連携
gem 'heroku'
group :development do
  # travis連携
  gem 'travis'
end
# css fremework compass
gem 'compass-rails'
gem 'parser', '2.2.0.pre.8'
# 擬似的なテーブルのように使える
gem 'active_hash'
# pagenate
gem 'kaminari'
# 暗号化
gem 'attr_encrypted'
# react rails
gem 'react-rails', '~> 1.0'
# assets 高速化
gem 'sprockets-derailleur'
# SQL発行場所を出力させる
gem 'activerecord-cause'
# ログ収集
gem "td"
gem "td-logger"
gem 'act-fluent-logger-rails'
gem 'fluent-plugin-mysqlslowquery'
gem 'fluent-plugin-elasticsearch'
gem 'fluent-plugin-slack'
gem 'lograge'
# breadcrumbs
gem "crummy",  "~> 1.8.0"
# elasticsearch
gem 'elasticsearch-rails'
gem 'elasticsearch-model'
# 複数DB対応
gem 'switch_point'
# dbスキーマ管理
gem 'ridgepole'
# 非同期・キューイング処理
gem 'sidekiq'
gem 'sinatra',  require: false
# レイアウト
gem 'bootstrap-sass'
gem "font-awesome-rails"
