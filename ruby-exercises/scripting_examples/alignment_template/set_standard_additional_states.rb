#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Set additional state to none for all elements'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    ats = AlignmentTemplate.all

    puts "\n---------------------------------------\n\n"

    puts "Alignment Templates:"
    puts ats.count


    puts "\n---------------------------------------\n\n"
    puts "Updating alignment templates..."


    ats.each do |at|
      at.elements.each do |el|
      	el.additional_state = "none"
      	el.save
      end
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished."
    puts "\n---------------------------------------\n\n"

  end
end