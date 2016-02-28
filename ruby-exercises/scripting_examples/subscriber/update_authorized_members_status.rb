require_relative '../script_init'

main_title 'Update Authorized Members Status'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do


    # ------------------------------------------------------------------------------

    puts "Get Authorized members confirmed but not registered..."
    puts "\n-------------------------------------------------------\n\n"

    subscribers = Subscriber.all_of(:status => "subscription_rate_sought", :type.ne => "organizational_account").to_a

    puts "Count"
    puts subscribers.count

    subscribers.each do |subscriber|
      puts "Confirm..."
      puts subscriber.email
      puts subscriber.status = "checkout"
      subscriber.save
      puts subscriber.errors.full_messages
      puts "\n-------------------------------------------------------\n\n"
    end


    puts "\n-------------------------------------------------------\n\n"
    puts "Finished updated authorized members."
    puts "\n-------------------------------------------------------\n\n"

  end
end