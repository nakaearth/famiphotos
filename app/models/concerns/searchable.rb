module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    unless Rails.env.test?
      # https://github.com/elastic/elasticsearch-rails/tree/master/elasticsearch-model#asynchronous-callbacks
      after_save { ElPhotoWorker.perform_async(:index, self.id) }
      after_save { ElPhotoWorker.perform_async(:delete, self.id) }
    end

    index_name "famiphoto"

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
            tokenizer: "ngram_tokenizer"
          }
        }
      }
    } do
      mapping _source: { enabled: true },
              _all: { enabled: true, analyzer: "kuromoji_analyzer" } do
        indexes :id, type: 'integer', index: 'not_analyzed'
        indexes :description, type: 'string', analyzer: 'kuromoji_analyzer'
      end
    end

    def as_indexed_json(_options = {})
      as_json
    end
  end

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
  end
end
