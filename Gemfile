source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'famiphotos_platform', git: 'https://github.com/nakaearth/famiphotos_platform.git', branch: 'master'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0'
gem 'rake', '~> 12.0'
# Use mysql as the database for Active Record
#gem 'mysql2', ' ~> 0.3.18'
gem 'mysql2'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Use Rack CORS for handling Cross-Origin Resource Sharing ()
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# スキーマ管理
gem 'ridgepole'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platform: :mri
  gem 'byebug', '~> 9.0.6'
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
  gem "pry-doc"
  gem 'pry-byebug'
  gem 'test-queue'
  # バグの起こりやすい箇所を数値化
  gem 'bugspots'
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
  # travis連携
  gem 'travis'
#  gem "awesome_print"
#  gem "better_errors"
#  gem "quiet_assets"
#  # mail test
  gem 'letter_opener'
#  # 静的解析
  gem "rubycritic", :require => false
  gem 'pre-commit'
end

group :test do
  gem 'rspec-rails'
  gem 'rspec-mocks'
  # rakeのテスト用
  gem 'rake_shared_context'
  gem 'rspec-request_describer'
  gem 'factory_girl_rails'
  # gem 'database_rewinder', '0.6'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
#
  # コードカバレッジ
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false

  # coverallsとの連携
  gem 'coveralls', require: false
  gem 'request_store'

  # 良い書き方しているかチェック
  gem 'rails_best_practices'

  gem 'rb-readline'
#  gem "rake-compiler"
  # webテスト
  gem 'capybara'
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
# 画像アップロード
gem 'carrierwave'
gem 'mini_magick'
# 画像ライブラリ
gem 'rmagick'
# 位置情報
gem 'geocoder'
# 権限チェック
gem "pundit"
# fluentの設定
gem 'fluent-plugin-mysqlslowquery'
gem 'fluent-plugin-elasticsearch'
gem 'fluent-plugin-slack'
gem 'fluent-plugin-rewrite-tag-filter'
#
gem 'lograge'
# breadcrumbs
gem "crummy",  "~> 1.8.0"
# elasticsearch
gem 'elasticsearch-rails'
gem 'elasticsearch-model'
# 複数DB対応
gem 'switch_point'
# enumerize
gem 'enumerize'
# カレンダー表示
gem 'simple_calendar',  '~> 2.0'

# 定数設定
gem 'config'
# ログ収集
# treasure data
gem "td"
gem "td-logger"
gem "ltsv-logger"
# モーダル
gem 'twitter-bootstrap-rails'
gem 'bootstrap-modal-rails'
gem "font-awesome-rails"
# ブラウザ判定、UA判定に使う
gem 'browser'
# css fremework compass
gem 'compass-rails'
gem 'parser'
# 擬似的なテーブルのように使える
gem 'active_hash'
# pagenate
gem 'kaminari'
# 暗号化
gem 'attr_encrypted'
# react rails
gem 'react-rails'
# assets 高速化
# gem 'sprockets-derailleur'
# SQL発行場所を出力させる
gem 'activerecord-cause'

# 動画サービス連携
gem 'Ziggeo'

# プロセス管理
gem 'foreman'
