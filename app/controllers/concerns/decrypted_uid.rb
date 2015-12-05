module DecryptedUid
  extend ActiveSupport::Concern

  def decrypted
    Base64.decode64(params[:uid])
  rescue
    # 例外を投げる
  end
end
