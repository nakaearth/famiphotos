# frozen_string_literal: true
class PhotoGeoSearch
  include ActiveModel::Model

  attr_accessor :search_word, :address
end
