require_relative '../script_init'

main_title 'Set Publisher Index Fields'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    def migrate_publishers(publishers)
      publishers.each do |publisher|
        publisher.set(:rfp_sent_date, publisher.rfp_sent_at.strftime("%Y/%m/%d")) if publisher.rfp_sent_at.present?
        publisher.set(:confirmed_date, publisher.confirmed_at.strftime("%Y/%m/%d")) if publisher.confirmed?
        publisher.set(:created_date, publisher.created_at.strftime("%Y/%m/%d"))
        publisher.set(:contact_name, "#{publisher.first_name} #{publisher.last_name}")
        if publisher.sign_in_count == 0
          publisher.set(:registered, 'No')
        else
          publisher.set(:registered, 'Yes')
        end

        puts "\n-------------------------------------------------------\n\n"
        puts "Migrated #{publisher.company_name}"
        puts publisher.inspect
        puts "\n-------------------------------------------------------\n\n"

      end
    end

    publishers = Publisher.all
    migrate_publishers(publishers)


    puts "\n-------------------------------------------------------\n\n"
    puts "Finished migrating publishers."
    puts "\n-------------------------------------------------------\n\n"


  end
end