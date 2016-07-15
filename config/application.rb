require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Famiphotos
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb, yml}').to_s]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # fluentd
    # ltsv形式のログ出力
    # config.log_level = :info
    # config.logger = LTSV::Logger.open("log/rails_application.log")
    # ActFluentLoggerを使う場合の設定
    # config.logger = ActFluentLoggerRails::Logger.new
    # config.lograge.enabled = true
    # config.lograge.formatter = Lograge::Formatters::Json.new

    # add lib directory
    config.autoload_paths << Rails.root.join('lib', 'constraints')

    # query cache
    config.middleware.swap ActiveRecord::QueryCache,  SwitchPoint::QueryCache

    config.active_job.queue_adapter = :sidekiq # アダプターの設定を追記
    config.generators do |g|
      g.orm :active_record, migration: false
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.jbuilder false
      g.test_framework :minitest, fixture: false
    end

    # babelを使ってコンパイルするように指定
    config.browserify_rails.commandline_options = '-t babelify'

    # cache store
    redis_config = Rails.application.config_for(:redis)
    config.cache_store = :redis_store, "redis://#{redis_config[:host]}:#{redis_config[:port]}/0/cache", { expires_in: 90.minutes }
  end
end
