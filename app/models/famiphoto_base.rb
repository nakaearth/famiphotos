# frozen_string_literal: true
class FamiphotoBase < ActiveRecord::Base
  self.abstract_class = true

  include IdEncryptable

  ####################################################################
  ################### Association ####################################
  ####################################################################

  ####################################################################
  ################### Validation #####################################
  ####################################################################

  ####################################################################
  ################### コールバック群 #################################
  ####################################################################

  ####################################################################
  ################### クラスメソッド #################################
  ####################################################################
  class << self
  end

  ####################################################################
  ################### インスタンスメソッド ###########################
  ####################################################################
  private

  def respond_to_missing?(_method_name, _include_private = fals)
    false
  end

  def method_missing(method_name, *_args, &_block)
    return super unless method_name.to_s.end_with?('_ymd')

    method_name_except_format_value = method_name.to_s.sub!(/_ymd/, '')
    column_names = self.class.column_names.select { |column_name| column_name =~ /.*_at/ }

    return unless column_names.include?(method_name_except_format_value)

    read_attribute(method_name_except_format_value).strftime('%Y/%m/%d')
  end
end
