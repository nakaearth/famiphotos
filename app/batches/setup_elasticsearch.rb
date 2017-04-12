# frozen_string_literal: true
require 'optparse'

# 1) 新規にindexを作成/データのimportをする場合
# bundle exec rails runner SetupElasticsearch.execute
# 2) 既にindexがあって、再構築する場合
# bundle exec rails runner SetupElasticsearch.execute --force=true
#
class SetupElasticsearch
  class << self
    def execute
      logger = ActiveSupport::Logger.new("log/#{class_name}_batch.log", 'daily')
      force = args[:force] || false

      logger.info('index作成')
      Photo.create_index!(force: force)
      logger.info('alias作成')
      Photo.create_alias!
      # importする
      logger.info('========= データ登録 =========')
      Photo.bulk_import
      logger.info('========データ登録完了しました ========')
    end

    private

    def args
      options = {}

      OptionParser.new do |o|
        o.banner = "Usage: #{$PROGRAM_NAME} [options]"
        o.on('--force=OPT', 'option1') { |v| options[:force] = v }
      end.parse!(ARGV.dup)

      options
    end
  end
end
