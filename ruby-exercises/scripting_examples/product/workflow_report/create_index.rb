require_relative '../../script_init'

main_title 'Create Product Workflow Report Index'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Creating index..."

    workflow = Domain::Product::Reports::Workflow::Index.new
    workflow.create_index! force: true

    Domain::Product::Reports::Workflow::IndexBuilder.!

    puts "\n====================================\n\n"
    puts "Index created."
  end
end