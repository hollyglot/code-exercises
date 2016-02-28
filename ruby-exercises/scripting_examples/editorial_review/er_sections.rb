#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Break Editorial Review into Sections'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "All:"
    puts ProductReview.count


    ############################   SET INTRO   ###################################

    ers = ProductReview.all


    puts "\n---------------------------------------\n\n"

    ers.each do |er|
      assess = er.assessments

      puts "\n---------------------------------------\n\n"

      puts assess

      puts "\n---------------------------------------\n\n"
    end

  end
end