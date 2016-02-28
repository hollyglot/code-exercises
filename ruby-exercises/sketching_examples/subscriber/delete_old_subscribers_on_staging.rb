require_relative '../sketches_init'

main_title 'Delete Old User on Staging'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    # ------------------------------------------------------------------------------

    puts "Getting Subscriber accounts older than 3 months...."

    subscribers = Subscriber.where(:created_at.lte => (Date.today - 90)).to_a

    puts "\n-------------------------------------------------------\n\n"

    if subscribers
      puts "Suscribers..."
      puts subscribers.count
      subscribers.each do |subscriber|
        puts "Subscriber:"
        puts subscriber.email
        puts subscriber.id
        puts subscriber.created_at
        puts "\n-------------------------------------------------------\n\n"
        subscriber.delete
      end
    end

    puts "\n-------------------------------------------------------\n\n"
    puts "Finished setting authorized users statuses."
    puts "\n-------------------------------------------------------\n\n"

  end
end