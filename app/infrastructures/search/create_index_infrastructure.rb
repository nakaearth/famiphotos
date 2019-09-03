# frozen_string_literal: true
module Search
  class CreateIndexInfrastructure < BaseSearchInfrastructure
    class << self
      def call(index_name)
        Elasticsearch::Model.client = client
        elasticsearch_client = Elasticsearch::Model.client
        if client.indices.exists? index: index_name
          client.indices.delete index: index_name
        end

        client.indices.create(
          index: index_name,
          include_type_name: true,
          body: {
            settings: Album.settings.to_hash,
            mappings: Album.mappings.to_hash
          }
        )
      end
    end
  end
end
