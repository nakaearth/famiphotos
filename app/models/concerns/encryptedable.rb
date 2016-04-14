module Encryptedable
  extend ActiveSupport::Concern

  module ClassMethods
    def attr_encrypted(*columns)
      columns.map(&:to_s).each do |column|
        value = Base64.encode64(read_attribute(column))
        write_attribute(column, value) 
      end 
    end
  end
end
