require_relative '../script_init'

main_title 'Update Subscription Price'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do


    puts "\n---------------------------------\n\n"
    puts "Creating Tier 12..."

    tier12 = SubscriptionPrice.create!(tier: 12, min_enrollment: 200000, max_enrollment: 999999, min_price: 28151, max_price: 59750, subscription_type: 'organizational_account')

    puts "\nTier 12:"
    puts tier12.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Tier 13..."

    tier13 = SubscriptionPrice.create!(tier: 13, min_enrollment: 1000000, max_enrollment: 2000000, min_price: 59751, max_price: 61750, subscription_type: 'organizational_account')

    puts "\nTier 13:"
    puts tier13.inspect



    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
 
  end
end