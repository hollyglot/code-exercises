#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Set aligned citations by aligned to standard value'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    alignment_reports = AlignmentReport.find ["52d83994f983f53e1d0034a3", "52d83d77f983f546cb002bb9", "52def4caf983f572ad00049e", "52def687f983f5de3d000431", "52def7fff983f5a4b10003a9", "52defd96f983f5de3d000529", "526e8533f983f5f682000018", "526e850df983f545930000ca", "526e84dbf983f52ae0000097", "526edc20f983f54593000306", "526e848ef983f5459300001a", "526e8459f983f52ae0000016"]

    alignment_reports.each do |ar|
      breakouts = ar.breakouts
      breakouts.each do |b|
        if b.addressed == "satisfied"
          b.notes = "The state panel found this standard to be aligned. See the state alignment report for the citations they reviewed."
          b.save
        end
      end
    end

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end