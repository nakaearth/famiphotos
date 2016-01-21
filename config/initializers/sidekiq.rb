redis_config = Rails.application.config_for(:redis)

redis_connection = proc {
  Redis.new(
    host: redis_config[:host],
    port: redis_config[:port],
    namespace: "#{Rails.env}:#{redis_config['namespace']}",
    password: redis_config['password']
  )
}

Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 5,  &redis_connection)
end

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 5,  &redis_connection)
end
