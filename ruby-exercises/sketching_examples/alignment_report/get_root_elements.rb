require_relative '../sketches_init'

main_title 'Get Alignment Report'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do
    alignment_report = AlignmentReport.find '54f656fbaa83e69e52000001'
    ancestry_depth = alignment_report.alignment_template.standard.calculation_level
    standards = alignment_report.alignment_template.elements.where(ancestry_depth: ancestry_depth).to_a

    standards.each do |standard|
      puts standard.label
    end

    puts standards.count
  end
end

log.output!
