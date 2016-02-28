require_relative '../script_init'

main_title 'Set Products with Price $0.00 to N/A'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Getting Products..."

    products = Product.all

    products.each do |product|
      puts product.title
      fc = product.first_component
      up = fc.unit_price
      if up == "$0.00"
        fc.set(:unit_price, "N/A")
        puts fc.inspect
      else
        puts up
      end
    end

    puts "\n====================================\n\n"
    puts "Finished setting products."

  end
end