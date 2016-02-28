require_relative '../script_init'

main_title 'Remove Product table of contents'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Removing table of contents.."

    products = Product.all

    i = 0
    products.each do |p|
      p.components.each do |c|
        if c.table_of_contents && c.table_of_contents.url.present?
          c.remove_table_of_contents!
          c.unset(:table_of_contents)
          i += 1
        end
      end
    end

    puts "\n--------------------------------------------\n\n"
    puts "Removed table of contents for #{i} products"
    puts "\n--------------------------------------------\n\n"
  end
end