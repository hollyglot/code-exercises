#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Create missing breakouts'

log = Telemetry::MongoidLog
log.clear!

at_ids = ["552866ec8080f8c425000001",
"55286700b16e33bb07000001",
"5528670bb16e33d9f5000068",
"552c33363864ebc6e0000001",
"556db3d579e4c4f323000001",
"552d466d7d49eb8e0e000027",
"556dc3a47207772a1f000001"]

alignment_templates = AlignmentTemplate.find at_ids

alignment_templates.each do |alignment_template|
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
end


puts "Finished."


