#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Set Alignment Report Info Field'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "Setting info..."

    ars = AlignmentReport.all.to_a
    puts "Alignments Reports: #{ars.count}\n"
    ars.each_with_index do |ar, index|
      info = Domain::AlignmentReport::Builders::InfoBuilder.! ar
      ar.set(:info, info)
      puts "#{index + 1}. #{ar.title}\n"
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished setting info field."

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end