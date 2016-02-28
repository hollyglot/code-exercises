require_relative '../sketches_init'

main_title 'Get Alignment Report CSV'

log = Telemetry::MongoidLog
log.clear!

t = Benchmark.measure do

  ar = AlignmentReport.find '51e974d7f983f564ec0000e7'
  table = Domain::AlignmentReport::Builders::CSVBuilder.! ar

  puts "CSV"
  puts table
  puts "----------------------------------------\n"


end

log.output!

comment "Time #{t}"
