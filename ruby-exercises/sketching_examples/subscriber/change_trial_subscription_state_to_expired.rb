require_relative '../sketches_init'

main_title 'Change state of subscription to expired if trial has expired'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n-----------------------------------------\n\n"
    puts 'Getting trial subscriptions ...'

    Subscription.trial.each do |subscription|
      puts "Checking if trial is expired..."
      if subscription.expire_at.present?
        if Date.current > subscription.expire_at
          puts "This subscription's state is now set to expired:"
          subscription.expire!
          puts subscription.inspect
          puts '------------------'
        end
      end
    end
    puts "Done!"
  end
end