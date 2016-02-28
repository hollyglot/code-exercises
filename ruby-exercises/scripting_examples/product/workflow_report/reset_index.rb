require_relative '../../script_init'

main_title 'Reset Product Workflow Report Index'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Resetting index..."

    puts "\n------------------------------------\n\n"
    puts "Getting products..."

    products = Product.all

    puts "\n------------------------------------\n\n"
    puts "Unsetting workflow ids products..."
    products.each {|p| p.unset(:workflow_ids)}

    puts "\n------------------------------------\n\n"
    puts "Deleting product workflow index..."

    workflow = Domain::Product::Reports::Workflow::Index.new
    workflow.create_index! force: true

    puts "\n------------------------------------\n\n"
    puts "Creating product workflow index..."
    Domain::Product::Reports::Workflow::IndexBuilder.!

    puts "\n====================================\n\n"
    puts "Finished resetting product workflow index."
  end
end