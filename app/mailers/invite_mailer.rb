class InviteMailer < ApplicationMailer
  default form: ENV['FAMIPHOTO_MAILADDRESS']

  def send_invite_mail(target_user)
    mail to: target_user.email
  end
end
