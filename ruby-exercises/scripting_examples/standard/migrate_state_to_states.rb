require_relative '../script_init'

main_title 'Unset Standard field State'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Migrate State to States.."

    standards = Standard.all

    standards.each do |s|
      state = s.state
      states = [""] + state.to_a
      s.set(:states, states)
    end

    ccss = Standard.where(name: 'CCSS').first
    ccss_states = []
    US_STATES.each do |state|
      ccss_states << state[1]
    end
    ccss_states.delete("TX")
    ccss.set(:states, ccss_states)


    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end