require 'test_helper'

class MailSendJobTest < ActiveJob::TestCase
  include ActiveJob::TestHelper

  setup do
    # TODO: なにか書く
  end

  teardown do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  def test_mail_send_success
    # assert_equal 0, queue_adapter.enqueued_jobs.size
    # MailSendJob.perform_later(~~~~~)
    # assert_equal 1, queue_adapter.enqueued_jobs.size

    # assert_equal 0, MailQueue.count
    # perform_enqueued_jobs { MailSendJob.perform_later(~~~) }
    # assert_equal 1, MailQueue.count

    # actual_contents = MailQueue.first.contents
    # assert_includes actual_contents, '提供依頼'
  end
end
