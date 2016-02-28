require_relative '../script_init'

main_title 'Published Products Missing Alignment Reports'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Getting Deleted Alignment Reports..."
    ars = AlignmentReport.deleted.all.to_a

    products = []

    ars.each do |ar|
      product = Domain::Product::Queries::Product.! ar.product_id
      if product
        if product.published? && product.alignment_reports.empty?
          products << product
        end
      end
    end

    puts "\n====================================\n\n"
    puts "Products missing alignment reports:"

    unless products.empty?
      products.each do |product|
        puts "\n---------------------------------\n\n"
        puts product.title
        puts "\n---------------------------------\n\n"
      end

      puts "\n====================================\n\n"
      puts "Done."
      puts "\n====================================\n\n"
    else
      puts "None."
      puts "\n====================================\n\n"
    end

  end
end