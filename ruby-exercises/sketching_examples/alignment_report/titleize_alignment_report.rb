#!/bin/env ruby
# encoding: utf-8

require_relative '../sketches_init'

main_title 'Titleize Alignment Report Breakouts'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n-----------------------------------------\n\n"
    puts 'Getting alignment report...'

    ar = AlignmentReport.find '54adb791dd264a472f000177'

    puts "\n---------------------------------------\n\n"

    breakouts = ar.breakouts
    breakouts.each do |breakout|
      breakout.pages = breakout.pages.titleize.gsub("2 B", "2B").gsub("2 A", "2A").gsub("3 B", "3B").gsub("3 A", "3A") if breakout.pages
      breakout.significant_differences = breakout.significant_differences.titleize.gsub("2 B", "2B").gsub("2 A", "2A").gsub("3 A", "3A").gsub("3 B", "3B") if breakout.significant_differences
      breakout.save
    end

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end