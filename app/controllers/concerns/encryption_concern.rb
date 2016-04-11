module EncryptionConcern
  extend ActiveSupport::Concern

  def decrypted(param)
    Base64.decode64(param)
  rescue
    # TODO: 何か例外クラス作ってそれを投げる
    fail 'デコード失敗しました'
  end

  def encrypted(param)
    Base64.encode64(param)
  rescue
    # TODO: 何か例外クラス作ってそれを投げる
    fail 'エンコード失敗しました'
  end
end
