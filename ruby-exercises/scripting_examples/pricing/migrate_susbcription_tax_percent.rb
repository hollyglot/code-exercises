require_relative '../script_init'

main_title 'Migrate Subscription Tax Percent to Tax Rate'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "Getting Subscriptions..."
    subscriptions = Subscription.all.to_a

    puts "\n-------------------------------------------------------\n\n"

    puts "Subscriptions Count"
    puts subscriptions.count
    puts "\n-------------------------------------------------------\n\n"

    puts "Migrating tax_percent content to tax_rate..."
    subscriptions.each do |subscription|
      puts "Subscription:"
      puts subscription.id
      puts "\n-------------------------------------------------------\n\n"

      subscription.tax_rate = (subscription.tax_percent / 100)
      subscription.save
    end

    puts "\n-------------------------------------------------------\n\n"
    puts "Finished migrating subscription tax rate."
    puts "\n-------------------------------------------------------\n\n"

  end
end