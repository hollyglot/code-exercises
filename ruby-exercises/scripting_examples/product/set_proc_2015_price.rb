require_relative '../script_init'

main_title 'Set Proc 2015 Products Price to TBD'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Getting Proc 2015 Products..."

    proc2015_products = Product.where(:publish_without_alignment_report => true)

    proc2015_products.each do |product|
      puts product.title
      fc = product.first_component
      fc.set(:unit_price, "TBD")
      puts fc.inspect
    end

    puts "\n====================================\n\n"
    puts "Finished setting products."

  end
end