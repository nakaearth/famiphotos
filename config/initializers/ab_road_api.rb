require 'search/ab_road_api/configure'

# config/redis.ymlの内容をパースして環境毎の値を取得
api_config = Rails.application.config_for(:ab_road_api)

Search::AbRoadApi::Configure.configure do |config|
  config.key = api_config['AB_ROAD_KEY']
end
