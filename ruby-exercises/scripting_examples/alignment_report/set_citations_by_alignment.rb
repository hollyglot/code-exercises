#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Set aligned citations by aligned to standard value'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    alignment_reports = AlignmentReport.find ["54f9ff9df924ef72f3000230", "54f9ff1ff924ef72f3000064", "54f9ff2ff924ef7ff50000ad", "54f9ff3ef924ef7ff50001b2", "54f9ff5bf924ef72f300018a", "54f9ff6bf924ef23f900002c"]

    alignment_reports.each do |ar|
      breakouts = ar.breakouts
      breakouts.each do |b|
        if b.addressed == "satisfied"
          b.pages = "The state panel found this standard to be aligned. See the state alignment report for the citations they reviewed."
          b.save
        end
      end
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished creating alignment reports for Algebra II products."

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end