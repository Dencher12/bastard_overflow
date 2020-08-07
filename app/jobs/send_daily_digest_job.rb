class SendDailyDigestJob < ApplicationJob
  queue_as :mailers

  def perform(*args)
    User.send_daily_digest
  end
end
