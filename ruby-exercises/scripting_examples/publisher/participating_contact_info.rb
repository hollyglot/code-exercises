require_relative '../script_init'

main_title 'Get contact info for participating publishers'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Update publishers..."

    publishers = Publisher.all

    puts "\n---------------------------------\n\n"
    puts "Publishers:"
    puts publishers.count

    puts "Company, First Name, Last Name, Email, Phone"
    publishers.each do |publisher|
      if publisher.products.count > 0
        puts "#{publisher.company_name}, #{publisher.first_name}, #{publisher.last_name}, #{publisher.email}, #{publisher.company_phone}"
      end
    end

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
 
  end
end