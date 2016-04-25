module DecryptedId
  extend ActiveSupport::Concern

  def decrypted_id(id)
    Base64.decode64(id)
  rescue
    # TODO: 何か例外クラス作ってそれを投げる
    fail 'デコード失敗しました'
  end

  def encrypted_id(id)
    Base64.encode64(id)
  rescue
    # TODO: 何か例外クラス作ってそれを投げる
    fail 'エンコード失敗しました'
  end
end
