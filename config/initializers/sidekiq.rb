Sidekiq.configure_server do |config|
  case Rails.env
    when 'production' then
      config.redis = { url: 'redis://production.redis-hoge.com:6379', namespace: 'sidekiq' }
    else
      # config.redis = { url: 'redis://192.168.25.30:6379', namespace: 'sidekiq' }
      config.redis = { url: 'redis://127.0.0.1:6379', namespace: 'sidekiq' }
  end
end

Sidekiq.configure_client do |config|
  case Rails.env
    when 'production' then
      config.redis = { url: 'redis://production.redis-hoge.com:6379', namespace: 'sidekiq' }
    else
      # config.redis = { url: 'redis://192.168.25.30:6379', namespace: 'sidekiq' }
      config.redis = { url: 'redis://127.0.0.1:6379', namespace: 'sidekiq' }
  end
end
