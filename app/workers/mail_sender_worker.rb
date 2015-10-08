class MailSenderWorker
  include Sidekiq::Worker

  def perform(*_args)
    # Do something
  end
end
