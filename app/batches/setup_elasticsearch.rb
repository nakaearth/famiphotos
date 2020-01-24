# frozen_string_literal: true
require 'optparse'

# 1) 新規にindexを作成/データのimportをする場合
# bundle exec rails runner SetupElasticsearch.execute
#
class SetupElasticsearch
  class << self
    def execute
      logger = ActiveSupport::Logger.new("setting_batch.log", 'daily')
      logger.info('index作成')
      Search::ElasticsearchIndexGateway.create_index('albums')
      Search::ElasticsearchIndexGateway.create_index('groups')
      logger.info('index作成終了')
    end
  end
end
