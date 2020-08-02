job = Sidekiq::Cron::Job.new(name: 'DailyDigestWorker', cron: '* * */1 * *', class: 'DailyDigestWorker')

unless job.save
  Rails.logger.info job.errors 
end