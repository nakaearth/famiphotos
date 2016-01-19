class ElPhotoWorker
 include Sidekiq::Worker
 include Elasticsearch::Model

  sidekiq_options queue: 'elasticsearch', retry: false

  def initialize
    @logger = Sidekiq.logger.level == Logger::DEBUG ? Sidekiq.logger : nil
    @client = __elasticsearch__.client logger: @logger
  end

  def perform(operation, record_id)
    @logger.debug [operation, "ID: #{record_id}"]

    case operation.to_s
      when /index/
        record = Photo.find(record_id)
        @client.index  index: 'famiphotos', type: 'article', id: record.id, body: record.as_indexed_json
      when /delete/
        @client.delete index: 'famiphotos', type: 'article', id: record_id
      else raise ArgumentError, "Unknown operation '#{operation}'"
    end
  end
end
