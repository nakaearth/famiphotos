# frozen_string_literal: true
module Searchable
  extend ActiveSupport::Concern

  # rubocop:disable all
  included do
    include Elasticsearch::Model

    if Rails.env.production?
      include Elasticsearch::Model::Callbacks
      after_save :transfer_to_elasticsearch
      after_destroy :remove_from_elasticsearch
    end

    index_name = Consts::Elasticsearch[:index_name][:photo]

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
        indexes :album_id, type: 'integer', index: 'not_analyzed'
        indexes :good_point, type: 'integer', index: 'not_analyzed'
        indexes :tag_name, type: 'string', index: 'not_analyzed'
      end
    end

    # TODO: groupとtagsてーぐるの値をいれる
    def as_indexed_json(_options = {})
      as_json.merge(as_indexed_json_tag(optoins))
    end

    def transfer_to_elasticsearch
      __elasticsearch__.client.index  index: index_name, type: 'photo', id: id, body: as_indexed_json
    end

    def remove_from_elasticsearch
      __elasticsearch__.client.delete index: index_name, type: 'photo', id: id
    end
  end
  # rubocop:enable all

  module ClassMethods
    def create_index!(options = {})
      client = __elasticsearch__.client
      client.indices.delete index: index_name if options[:force]
      client.indices.create index: index_name,
                            body: {
                              settings: settings.to_hash,
                              mappings: mappings.to_hash
                            }
    end

    def create_alias!
      client = __elasticsearch__.client
      if client.indices.exists_alias? name: Consts::Elasticsearch[:alias_name][:photo]
        client.indices.delete_alias index: index_name, name: Consts::Elasticsearch[:alias_name][:photo]
      end

      client.indices.put_alias index: index_name, name: Consts::Elasticsearch[:alias_name][:photo]
    end

    def bulk_import
      es = __elasticsearch__

      find_in_batches.with_index do |entries, i|
        es.client.bulk(
          index: es.index_name,
          type: es.document_type,
          body: entries.map { |entry| { index: { _id: entry.id, data: entry.as_indexed_json } } },
          refresh: (i.positive? && (i % 3).zero?), # NOTE: 定期的にrefreshしないとEsが重くなる
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
