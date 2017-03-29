module EncryptionConcern
  extend ActiveSupport::Concern

  def decrypted(param)
    Base64.decode64(param)
  rescue
    # TODO: 何か例外クラス作ってそれを投げる
    raise 'デコード失敗しました'
  end

  def encrypted(param)
    Base64.encode64(param)
  rescue
    # TODO: 何か例外クラス作ってそれを投げる
    raise 'エンコード失敗しました'
  end
end
