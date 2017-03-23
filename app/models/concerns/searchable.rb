# frozen_string_literal: true
module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    if Rails.env.production?
      include Elasticsearch::Model::Callbacks
      after_save :transfer_to_elasticsearch
      after_destroy :remove_from_elasticsearch
    end

    # Set up index configuration and mapping
    settings index: {
      number_of_shards:   5,
      number_of_replicas: 1,
      analysis: {
        filter: {
          pos_filter: {
            type:     'kuromoji_part_of_speech',
            stoptags: ['助詞-格助詞-一般', '助詞-終助詞']
          },
          greek_lowercase_filter: {
            type:     'lowercase',
            language: 'greek'
          },
          kuromoji_ks: {
            type: 'kuromoji_stemmer',
            minimum_length: '5'
          }
        },
        tokenizer: {
          kuromoji: {
            type: 'kuromoji_tokenizer'
          },
          ngram_tokenizer: {
            type: 'nGram',
            min_gram: '2',
            max_gram: '3',
            token_chars: %w(letter digit)
          }
        },
        analyzer: {
          kuromoji_analyzer: {
            type:      'custom',
            tokenizer: 'kuromoji_tokenizer',
            filter:    %w(kuromoji_baseform pos_filter greek_lowercase_filter cjk_width)
          },
          ngram_analyzer: {
            tokenizer: 'ngram_tokenizer'
          }
        }
      }
    } do
      mapping _source: { enabled: true },
              _all: { enabled: true, analyzer: 'kuromoji_analyzer' } do
        indexes :id, type: 'integer', index: 'not_analyzed'
        indexes :description, type: 'string', analyzer: 'kuromoji_analyzer'
        indexes :group_id, type: 'integer', index: 'not_analyzed'
        indexes :tag_name, type: 'string', index: 'not_analyzed'
      end
    end

    # TODO: groupとtagsてーぐるの値をいれる
    def as_indexed_json(_options = {})
      as_json.merge(as_indexed_json_tag(optoins))
    end

    def transfer_to_elasticsearch
      __elasticsearch__.client.index  index: Consts::Elasticsearch[:index_name][:photo], type: 'photo', id: id, body: as_indexed_json
    end

    def remove_from_elasticsearch
      __elasticsearch__.client.delete index: Consts::Elasticsearch[:index_name][:photo], type: 'photo', id: id
    end
  end

  module ClassMethods
    def create_index!(options = {})
      client = __elasticsearch__.client
      client.indices.delete index: Consts::Elasticsearch[:index_name][:photo] if options[:force]
      client.indices.create index: Consts::Elasticsearch[:index_name][:photo],
                            body: {
                              settings: settings.to_hash,
                              mappings: mappings.to_hash
                            }
    end

    def create_alias!
      client = __elasticsearch__.client
      if client.indices.exists_alias? name: Consts::Elasticsearch[:alias_name][:photo]
        client.indices.delete_alias index: Consts::Elasticsearch[:index_name][:photo], alias_name: Consts::Elasticsearch[:alias_name][:photo]
      end

      client.indices.put_alias index: Consts::Elasticsearch[:index_name][:photo], name: Consts::Elasticsearch[:alias_name][:photo]
    end

    def bulk_import
      client = __elasticsearch__.client

      find_in_batches.with_index do |entries, i|
        result = client.bulk(
          index: index_name,
          type: document_type,
          body: entries.map { |entry| { index: { _id: entry.id, data: entry.as_indexed_json } } },
          refresh: (i > 0 && i % 3 == 0), # NOTE: 定期的にrefreshしないとEsが重くなる
        )
      end
    end
  end

  private

  def as_indexed_json_tag(_options = {})
    return {} unless tags

    tag_maps = tags.map(&:name)

    { tag_name: tag_maps }
  end
end
