class SendDailyDigestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.send_daily_digest
  end
end
