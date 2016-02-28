require_relative '../sketches_init'

main_title 'Subscribers with Subscriptions at $0'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------------\n\n"

    sub_subscriptions = []

    subscribers = Subscriber.all.to_a

    subscribers.each do |subscriber|
      if subscriber.current_subscription && subscriber.current_subscription.annual_cost == 0
        sub_subscriptions << subscriber
      end
    end

    puts 'Subscribers...'
    puts "\n---------------------------------------\n\n"
    puts "Subscriber:"
    annual = []
    sub_subscriptions.each { |subscriber| annual << "#{subscriber.first_name} #{subscriber.last_name}\nAnnual Cost: #{subscriber.current_subscription.annual_cost.to_s}\n---------------------------------------\n\n" }

    annual.each do |an|
      puts an
    end

    puts 'Done!'

  end
end