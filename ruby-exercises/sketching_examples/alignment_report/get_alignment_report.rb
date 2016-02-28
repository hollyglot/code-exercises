require_relative '../sketches_init'

main_title 'Get Alignment Report'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do
    alignment_report = AlignmentReport.last
    alignment_report.alignment_template.elements.count
  end
end

log.output!
