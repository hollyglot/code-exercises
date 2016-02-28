require_relative '../script_init'

main_title 'Unset Standard field State'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Unsetting State.."

    standards = Standard.all

    standards.each do |s|
      s.unset(:state)
    end

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end