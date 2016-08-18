class SetupElasticsearch

  class << self
    def execute
      logger = ActiveSupport::Logger.new("log/#{class.name}_batch.log", 'daily')
      # TODO: indexがすでに会ったら、forceオプションをtrueにする
      Photo.create_index!
      # TODO: aliasをつける
      # importする
    end
  end
end
