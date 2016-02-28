require_relative '../script_init'

main_title 'Unset Product Kind'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Unsetting kind.."

    products = Product.all

    products.each do |p|
      p.unset(:kind)
      p.components.each do |c|
        c.unset(:kind)
      end
    end

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end