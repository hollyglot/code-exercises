require_relative '../script_init'

main_title 'Unset Subscription Tax Percent'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "Getting all Subscription documents..."
    subscriptions = []
    subscriptions = Subscription.all.to_a

    puts "\n=====================================\n\n"

    subscriptions.each do |subscription|
      puts "\n---------------------------------\n\n"
      puts "Subscription:"
      puts subscription.inspect

      puts "\n---------------------------------\n\n"
      puts "Unsetting tax percent attribute..."
      subscription.unset(:tax_percent)
    end

    puts "Checking all Subscription documents..."
    subscriptions = []
    subscriptions = Subscription.all.to_a

    subscriptions.each do |subscription|
      puts "\n---------------------------------\n\n"
      puts "Subscription:"
      puts subscription.inspect
    end

    puts "\n=====================================\n\n"
    puts "Done."
    puts "\n=====================================\n\n"
  end
end