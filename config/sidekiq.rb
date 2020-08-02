Sidekiq::Extensions.enable_delay!
Sidekiq::Cron::Job.new(name: 'DailyDigestWorker', cron: '* * */1 * *', class: 'DailyDigestWorker')