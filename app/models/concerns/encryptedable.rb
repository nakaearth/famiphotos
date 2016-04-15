module Encryptedable
  extend ActiveSupport::Concern


  included do
    before_save :encrypted

    class_attribute :encrypt_columns
    @encrypt_columns = []
  end

  module ClassMethods
    def attr_encrypted(*columns)
      columns.map(&:to_s).each do |column|
        @encrypt_columns << column
      end 
    end
  end

  def encrypted
    @encrypted_columns.each do |encrypted_column|
      value = Base64.encode64(read_attribute(column))
      write_attribute(column, value) 
    end
  end
end
