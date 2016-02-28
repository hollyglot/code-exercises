#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Recalculate Alignment Report %'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    alignment_reports = AlignmentReport.all
    alignment_reports.each do |alignment_report|
      puts "\n\n---------------------------------------------"
      puts "Alignment Report:"
      puts alignment_report.title
      puts alignment_report.id

      puts "Original Coverage:"
      puts alignment_report.coverage_with_percent

      coverage = Domain::AlignmentReport::Commands::CalculateCoveragePercent.! alignment_report
      alignment_report.set(:coverage_percent, coverage.round)
      alignment_report.set(:coverage_with_percent, "#{coverage.round}%")

      puts "New Coverage:"
      puts "#{coverage}%"
    end

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end