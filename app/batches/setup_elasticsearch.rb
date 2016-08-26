require 'optparse'

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

      OptionParser.new { |o|
        o.banner = "Usage: #{$0} [options]"
        o.on("--force=OPT", "option1") { |v| options[:force] = v }
      }.parse!(ARGV.dup)

      options
    end
  end
end
