#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Unset Editorial Review Tech Requirements'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "All:"
    puts ProductReview.count


    ############################   SET INTRO   ###################################

    ers = ProductReview.all


    puts "\n---------------------------------------\n\n"

    ers.each_with_index do |er, index|
      puts "##{index + 1}"
      er.unset(:technology_requirements)
    end


    puts "\n---------------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------------\n\n"

  end
end