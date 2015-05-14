module IdEncryptable
  extend ActiveSupport::Concern

  # クラスメソッド
  module ClassMethod
  end

  # インスタンスメソッド
  def to_key
    [Base64.encode64(id.to_s)]
  end

  def to_param
    [Base64.encode64(id.to_s)]
  end
end
