require_relative '../../script_init'

main_title 'Reset Product Index'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Resetting product index..."

    puts "\n---------------------------------\n\n"
    puts "Creating index..."
    puts Product.__elasticsearch__.create_index! force: true

    puts "\n---------------------------------\n\n"
    puts "Importing published products..."
    puts Product.published.import

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end