require_relative '../sketches_init'

main_title 'Create missing breakouts'

log = Telemetry::MongoidLog
log.clear!


alignment_template = AlignmentTemplate.where(id: '54e2152cfd08c2487f000035').first
alignment_reports = alignment_template.alignment_reports
alignment_reports.each do |alignment_report|
  breakouts = alignment_report.breakouts
  alignment_template.elements.without_children.each do |element|
    matchElement = breakouts.select { |breakout| breakout.element_id == element.id }
    if matchElement.empty?
      breakout = element.breakouts.build
      alignment_report.breakouts << breakout
    end
  end
end

puts "Finished."


