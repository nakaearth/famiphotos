Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, ENV["TWITTER_FAMIPHOTOS_API_TOKEN"], ENV["TWITTER_FAMIPHOTOS_SECRET_TOKEN"]
end
# OmniAuth.config.on_failure = SessionsController.action(:oauth_failure)
