require_relative '../script_init'

main_title 'Unset Standard field Selected Level'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Unsetting Selected Level.."

    standards = Standard.all

    standards.each do |s|
      s.unset(:selected_level)
    end

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end