#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Unset flag and standard_name for all alignment_templates'

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
      at_hash = at.attributes
      at_hash.delete("standard_name")
      at_hash.delete("flag")
      at.assign_attributes(at_hash)
      at.save
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished."
    puts "\n---------------------------------------\n\n"

  end
end