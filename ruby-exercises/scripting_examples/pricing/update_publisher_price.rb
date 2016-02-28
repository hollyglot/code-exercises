require_relative '../script_init'

main_title 'Update publisher pricing'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Updating Publisher Pricing..."

    pub = SubscriptionPrice.where(subscription_type: 'publisher_account').first
    pub.min_price = 495
    pub.max_price = 495
    puts "\nPublisher Price:"
    puts pub.inspect
    pub.save


    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
 
  end
end