require_relative '../sketches_init'

main_title 'Alignment Report Calculation'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do
    ar = AlignmentReport.find '54f656fbaa83e69e52000001'
    coverage = Domain::AlignmentReport::Commands::CalculateCoveragePercent.! ar
    puts coverage
    # old method
    # 0.300000   0.020000   0.320000 (  0.382681) 206 queries

    # new method
    # 0.320000   0.010000   0.330000 (  0.334211) 19 queries
  end
end

log.output!