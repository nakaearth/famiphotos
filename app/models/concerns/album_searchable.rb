# frozen_string_literal: true
module AlbumSearchable
  extend ActiveSupport::Concern

  # rubocop:disable all
  included do
    include Elasticsearch::Model

    unless Rails.env.test?
      include Elasticsearch::Model::Callbacks
      #after_save :transfer_to_elasticsearch
      #after_destroy :remove_from_elasticsearch
    end

    index_name = Consts::Elasticsearch[:index_name][:album]

    # Set up index configuration and mapping
    settings index: {
      number_of_shards:   1,
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
            char_filter: [
              'icu_normalizer',
              'kuromoji_iteration_mark'
            ],
            filter: %w(kuromoji_baseform pos_filter greek_lowercase_filter cjk_width ja_stop kuromoji_number kuromoji_stemmer)
          },
          ngram_analyzer: {
            tokenizer: 'ngram_tokenizer'
          }
        }
      }
    } do
      mapping _source: { enabled: true } do
        indexes :id,          type: 'integer'
        indexes :title,       type: 'text', analyzer: 'kuromoji_analyzer'
        indexes :title2,       type: 'text', analyzer: 'ngram_analyzer'
        indexes :user_id,     type: 'integer'
        indexes :group_id,    type: 'integer'
        indexes :photos,      type: 'nested' do
          indexes :description, type: 'text', analyzer: 'kuromoji_analyzer'
          indexes :description2, type: 'text', analyzer: 'ngram_analyzer'
          indexes :user_id,   type: 'integer'
          indexes :good_point, type: 'integer'
        end
        indexes :total_point, type: 'integer'
        indexes :tags,        type: 'nested' do
          indexes :label_name, type: 'keyword'
        end
        indexes :created_at,  type: 'date', format: 'date_time'
        indexes :updated_at,  type: 'date', format: 'date_time'
      end
    end

    def as_indexed_json
      as_json.merge(as_indexed_json_photos)
        .merge({ title2: title})
        .merge(as_indexed_json_tags)
        .merge(as_indexed_json_total_photo_point)
    end

    def transfer_to_elasticsearch
      Elasticsearch::Model.client.index  index: index_name, type: '_doc', id: id, body: as_indexed_json
    end

    def remove_from_elasticsearch
      Elasticsearch::Model.client.delete index: index_name, type: '_doc', id: id
    end
  end
  # rubocop:enable all

  class_methods do
    def create_index!(options = {})
      elasticsearch_client = Elasticsearch::Model.client
      if elasticsearch_client.indices.exists? index: index_name
        elasticsearch_client.indices.delete index: index_name
      end

      elasticsearch_client.indices.create(
        index: index_name,
        include_type_name: true,
        body: {
          settings: settings.to_hash,
          mappings: mappings.to_hash
        }
      )
    end

    # def create_alias!
    #   client = ElasitcsearchClient.client
    #   if client.indices.exists_alias? name: Consts::Elasticsearch[:alias_name][:photo]
    #     client.indices.delete_alias index: index_name, name: Consts::Elasticsearch[:alias_name][:photo]
    #   end
    #
    #    client.indices.put_alias index: index_name, name: Consts::Elasticsearch[:alias_name][:photo]
    # end

    def bulk_import
      client = Elasticsearch::Model.client

      find_in_batches.with_index do |entries, _i|
        client.bulk(
          index: es.index_name,
          type: '_doc',
          body: entries.map { |entry| { index: { _id: entry.id, data: entry.as_indexed_json } } },
          refresh: true, # NOTE: 定期的にrefreshしないとEsが重くなる
        )
      end
    end
  end

  private

  def as_indexed_json_photos
    return {} unless photos

    { photos: photos.map(&:attributes).map { |ph| ph.merge({ description2: ph[:description] }) }}
  end

  def as_indexed_json_tags
    return {} unless tags

    { tags: tags.map(&:attributes) }
  end

  def as_indexed_json_total_photo_point
    return {} unless photos

    { total_point: photos.sum(:good_point) }
  end
end
