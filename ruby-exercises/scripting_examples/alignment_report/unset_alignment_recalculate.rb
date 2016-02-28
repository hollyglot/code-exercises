#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Unset alignment report recalculate field'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    alignment_reports = AlignmentReport.all

    alignment_reports.each do |ar|
      ar.unset(:recalculate)
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished unsetting recalculate."

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end