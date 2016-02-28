require_relative '../script_init'

main_title 'Populate Subscription Discount'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    # SubscriptionPrice.delete_all


    puts "\n---------------------------------\n\n"
    puts "Creating Tier 1..."

    tier1 = SubscriptionPrice.create!(tier: 1, min_enrollment: 1, max_enrollment: 249, min_price: 250, max_price: 250, subscription_type: 'organizational_account')

    puts "\nTier 1:"
    puts tier1.inspect


    puts "\n---------------------------------\n\n"
    puts "Creating Tier 2..."

    tier2 = SubscriptionPrice.create!(tier: 2, min_enrollment: 250, max_enrollment: 499, min_price: 251, max_price: 749, subscription_type: 'organizational_account')

    puts "\nTier 2:"
    puts tier2.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Tier 3..."

    tier3 = SubscriptionPrice.create!(tier: 3, min_enrollment: 500, max_enrollment: 999, min_price: 750, max_price: 1150, subscription_type: 'organizational_account')

    puts "\nTier 3:"
    puts tier3.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Tier 4..."

    tier4 = SubscriptionPrice.create!(tier: 4, min_enrollment: 1000, max_enrollment: 2499, min_price: 1151, max_price: 2549, subscription_type: 'organizational_account')

    puts "\nTier 4:"
    puts tier4.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Tier 5..."

    tier5 = SubscriptionPrice.create!(tier: 5, min_enrollment: 2500, max_enrollment: 4999, min_price: 2550, max_price: 4150, subscription_type: 'organizational_account')

    puts "\nTier 5:"
    puts tier5.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Tier 6..."

    tier6 = SubscriptionPrice.create!(tier: 6, min_enrollment: 5000, max_enrollment: 9999, min_price: 4151, max_price: 6549, subscription_type: 'organizational_account')

    puts "\nTier 6:"
    puts tier6.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Tier 7..."

    tier7 = SubscriptionPrice.create!(tier: 7, min_enrollment: 10000, max_enrollment: 14999, min_price: 6550, max_price: 8550, subscription_type: 'organizational_account')

    puts "\nTier 7:"
    puts tier7.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Tier 8..."

    tier8 = SubscriptionPrice.create!(tier: 8, min_enrollment: 15000, max_enrollment: 19999, min_price: 8551, max_price: 11349, subscription_type: 'organizational_account')

    puts "\nTier 8:"
    puts tier8.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Tier 9..."

    tier9 = SubscriptionPrice.create!(tier: 9, min_enrollment: 20000, max_enrollment: 49999, min_price: 11350, max_price: 16550, subscription_type: 'organizational_account')

    puts "\nTier 9:"
    puts tier9.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Tier 10..."

    tier10 = SubscriptionPrice.create!(tier: 10, min_enrollment: 50000, max_enrollment: 99999, min_price: 16551, max_price: 21343, subscription_type: 'organizational_account')

    puts "\nTier 10:"
    puts tier10.inspect


    puts "\n---------------------------------\n\n"
    puts "Creating Tier 11..."

    tier11 = SubscriptionPrice.create!(tier: 11, min_enrollment: 100000, max_enrollment: 200000, min_price: 21344, max_price: 28150, subscription_type: 'organizational_account')

    puts "\nTier 11:"
    puts tier11.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Publisher Pricing..."

    pub = SubscriptionPrice.create!(tier: 1000, min_enrollment: 0, max_enrollment: 1, min_price: 475, max_price: 475, subscription_type: 'publisher_account')

    puts "\nPublisher Price:"
    puts pub.inspect


    puts "\n---------------------------------\n\n"
    puts "Creating Individual Pricing..."

    individual = SubscriptionPrice.create!(tier: 1001, min_enrollment: 0, max_enrollment: 1, min_price: 65, max_price: 65, subscription_type: 'individual_account')

    puts "\nIndividual Price:"
    puts individual.inspect


    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
 
  end
end