require_relative '../script_init'

main_title 'Update Subscribers Status'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do


    # ------------------------------------------------------------------------------

    puts "Migrating Subscriber Subscription Type..."
    puts "\n-------------------------------------------------------\n\n"

    subscribers = Subscriber.all
    subscribers_with_subscriptions = []

    subscribers.each do |subscriber|
      if subscriber.current_subscription
        subscribers_with_subscriptions << subscriber
      end
    end

    puts "Subscribers with Subscriptions"
    puts subscribers_with_subscriptions.count

    subscribers_with_subscriptions.each do |subscriber|
      subscription = subscriber.current_subscription
      puts "Migrating Subscription Type..."
      puts "\n-------------------------------------------------------\n\n"
      subscription.type = 'annual'
      puts subscription.inspect
      puts subscription.save
    end


    puts "\n-------------------------------------------------------\n\n"
    puts "Finished migrating subscriber subscription type."
    puts "\n-------------------------------------------------------\n\n"

  end
end