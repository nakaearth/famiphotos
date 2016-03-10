module DecryptedUid
  extend ActiveSupport::Concern

  def decrypted_uid
    Base64.strict_decode64(params[:uid])
  rescue
    # TODO: 何か例外クラス作ってそれを投げる
    fail 'デコード失敗しました'
  end

  def encrypted_uid
    Base64.strict_encode64(params[:uid])
  rescue
    # TODO: 何か例外クラス作ってそれを投げる
    fail 'エンコード失敗しました'
  end
end
