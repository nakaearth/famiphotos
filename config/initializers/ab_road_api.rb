require 'search/extra_api/ab_road_api/configuration'

# config/ab_road_api.ymlの内容をパースして環境毎の値を取得
api_config = Rails.application.config_for(:ab_road_api)

Search::ExtraApi::AbRoadApi::Configuration.configure do |config|
  config.key = api_config['AB_ROAD_KEY']
end
