require_relative '../script_init'

main_title 'Set Publisher Name and Update At'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Getting Publishers..."

    publishers = Publisher.all

    publishers.each do |publisher|
      unless publisher.products.empty?
        publisher.products.each do |product|
          unless product.publisher_name == publisher.company_name
              puts "\n------------------------------------------\n\n"
              puts "Setting Publisher Name..."
              puts product.title
              product.set(:publisher_name, publisher.company_name)

              puts "Setting Updated At Date..."
              puts product.title
              product.set(:updated_at_date, product.updated_at.strftime("%Y/%m/%d"))
              puts product.inspect
              puts "\n------------------------------------------\n\n"
          end
        end
      end
    end

    puts "\n====================================\n\n"
    puts "Finished setting products."

  end
end