# frozen_string_literal: true
class SharedAlbum < FamiphotoBase
  ####################################################################
  ################# Association ######################################
  ####################################################################
  belongs_to :album

  ####################################################################
  ####################### Validation #################################
  ####################################################################
  validates :password, presence: true, length: { maximum: 30 }

  ####################################################################
  ##################### コールバック群 ###############################
  ####################################################################

  ####################################################################
  ##################### クラスメソッド ###############################
  ####################################################################
  class << self
  end

  ####################################################################
  ##################### インスタンスメソッド #########################
  ####################################################################
end
