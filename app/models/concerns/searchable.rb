module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    default_index_name "famiphoto"
  end
end
