#!/bin/env ruby
# encoding: utf-8

require_relative '../sketches_init'

main_title 'Remove Due Too Statement from Alignment Report'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n-----------------------------------------\n\n"
    puts 'Getting notes with span...'

    breakouts = Breakout.where(:notes => /<span/).to_a

    puts "\n---------------------------------------\n\n"
    brkts = []

    breakouts.each do |breakout|
      element = Element.where(id: breakout.element_id).first
      brkts << [breakout.alignment_report_id, element.label, breakout.notes]
    end

    puts brkts.count

    brkts.sort! { |a,b| a[0] <=> b[0] }

    brkts.each do |br|
      puts br.inspect
    end

    puts "\n-----------------------------------------\n\n"
    puts 'Getting pages with span...'

    breakouts = Breakout.where(:pages => /</).to_a

    puts "\n---------------------------------------\n\n"
    brkts = []

    breakouts.each do |breakout|
      element = Element.where(id: breakout.element_id).first
      brkts << [breakout.alignment_report_id, element.label, breakout.notes]
    end

    puts brkts.count

    brkts.sort! { |a,b| a[0] <=> b[0] }

    brkts.each do |br|
      puts br.inspect
    end

    puts "\n-----------------------------------------\n\n"
    puts 'Getting pages with ...'

    breakouts = Breakout.where(:significant_differences => /</).to_a

    puts "\n---------------------------------------\n\n"
    brkts = []

    breakouts.each do |breakout|
      element = Element.where(id: breakout.element_id).first
      brkts << [breakout.alignment_report_id, element.label, breakout.notes]
    end

    puts brkts.count

    brkts.sort! { |a,b| a[0] <=> b[0] }

    brkts.each do |br|
      puts br.inspect
    end

    puts "\n-----------------------------------------\n\n"
    puts 'Getting editors_notes with span...'

    breakouts = Breakout.where(:editors_notes => /</).to_a

    puts "\n---------------------------------------\n\n"
    brkts = []

    breakouts.each do |breakout|
      element = Element.where(id: breakout.element_id).first
      brkts << [breakout.alignment_report_id, element.label, breakout.editors_notes]
    end

    puts brkts.count

    brkts.sort! { |a,b| a[0] <=> b[0] }

    brkts.each do |br|
      puts br.inspect
    end

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end