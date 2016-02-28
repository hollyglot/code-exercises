require_relative '../script_init'

main_title 'Populate Subscription Promo'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Creating Publisher Promo..."
    pub_promo = SubscriptionPromo.create!(amount: 15, code: 'PUB15', expiration: '2100-12-31', type: 'percentage')

    puts "Promo:"
    puts pub_promo.inspect

    puts "Creating July Promo..."
    jul_promo = SubscriptionPromo.create!(amount: 20, code: 'JULYPROMO', expiration: '2014-07-04', type: 'percentage')

    puts "Promo:"
    puts jul_promo.inspect

    puts "Creating July Individual Promo..."
    ind_promo = SubscriptionPromo.create!(amount: 25, code: 'JULYPROMO25', expiration: '2014-07-04', type: 'percentage')

    puts "Promo:"
    puts ind_promo.inspect

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end