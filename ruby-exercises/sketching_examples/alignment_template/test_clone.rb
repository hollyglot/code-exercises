require_relative '../sketches_init'

main_title 'Clone Alignment Template'

log = Telemetry::MongoidLog
log.clear!

t = Benchmark.measure do

  id = '51a92088f983f55edb0017b5'
  original_at = AlignmentTemplate.find id

  puts "Cloning alignment template...\n"
  Domain::AlignmentTemplate::Commands::Clone.! original_at

  cloned_at = AlignmentTemplate.last
  puts "Clone:"
  puts cloned_at.inspect
end 

# log.output!

comment "Time #{t}"
