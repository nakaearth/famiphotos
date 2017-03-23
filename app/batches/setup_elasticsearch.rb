require 'optparse'

#
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

      Photo.create_index!(force: force)
      Photo.create_alias!
      # importする
      Photo.bulk_import
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
