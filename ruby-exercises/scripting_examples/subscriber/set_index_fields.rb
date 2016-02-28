require_relative '../script_init'

main_title 'Set Subscriber Index Fields'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    def migrate_subscribers(subscribers)
      subscribers.each do |subscriber|
        subscriber.set(:full_name, "#{subscriber.first_name} #{subscriber.last_name}")
        puts "\n-------------------------------------------------------\n\n"
        puts "Migrated #{subscriber.full_name}"
        puts subscriber.inspect
        puts "\n-------------------------------------------------------\n\n"

      end
    end

    subscribers = Subscriber.all
    migrate_subscribers(subscribers)


    puts "\n-------------------------------------------------------\n\n"
    puts "Finished migrating subscribers."
    puts "\n-------------------------------------------------------\n\n"


  end
end