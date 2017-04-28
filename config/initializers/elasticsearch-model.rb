# elasticsearchの設定ファイルを読み込む
module ElasticsearchConfig
  CONFIG ||= YAML.load_file("#{Rails.root}/config/elasticsearch.yml")[ENV['RAILS_ENV'] || 'development'].with_indifferent_access
end

class ElasticsearchClient
  class << self
    def master
      if Rails.env.production?
        urls = url('master')
        return connection_to_bonsai urls
      end

      connection_to_local hosts('master')
    end

    def slave
      if Rails.env.production?
        urls = urls('slave')
        return connection_to_bonsai urls
      end

      connection_to_local hosts('slave')
    end

    private

    def hosts(master_or_slave)
      hosts = []
      ElasticsearchConfig::CONFIG[master_or_slave][:host].each_with_index do |host, i|
        hosts << { host: host, port: ElasticsearchConfig::CONFIG[master_or_slave][:port][i] }
      end

      hosts
    end

    def url(master_or_slave)
      urls = []
      ElasticsearchConfig::CONFIG[master_or_slave][:url].each_with_index do |url, i|
        urls << { url: url }
      end

      urls
    end


    def connection_to_local(hosts)
      Elasticsearch::Client.new(
        hosts: hosts,
        randomize_hosts: true,
        request_timeout: 10,
        reload_connections: 500,
        sniffer_timeout: 3,
        reload_on_failure: false,
        log: false
      )
    end

    def connection_to_bonsai(urls)
      require 'faraday_middleware/aws_signers_v4'

      Elasticsearch::Client.new(
        url: urls,
        randomize_hosts: true,
        request_timeout: 10,
        reload_connections: false,
        sniffer_timeout: 3,
        reload_on_failure: false,
        transport_options: { headers: { content_type: 'application/json' } },
        log: true
      )
    end
  end
end
