class MailSendJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    # TODO: ここにsidekikを使った非同期処理を書く
  end
end
