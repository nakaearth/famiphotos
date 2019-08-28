# frozen_string_literal: true
class Tag < FamiphotoBase
  include Searchable

  ####################################################################
  ################# Association ######################################
  ####################################################################
  belongs_to :user, optional: true
  # belongs_to :group
  belongs_to :album, optional: true

  ####################################################################
  ####################### Validation #################################
  ####################################################################
  validates :label_name, presence: true

  ####################################################################
  ##################### コールバック群 ###############################
  ####################################################################

  ####################################################################
  ##################### インスタンスメソッド #########################
  ####################################################################
end
