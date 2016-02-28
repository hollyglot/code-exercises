#!/bin/env ruby
# encoding: utf-8

require_relative '../sketches_init'

main_title 'Find breakouts with <span>'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n-----------------------------------------\n\n"
    puts 'Getting notes with <...'

    breakouts = Breakout.where(:notes => /</).to_a

    puts "\n---------------------------------------\n\n"
    brkts = []

    breakouts.each do |breakout|
      if breakout.notes
        string = breakout.notes
        if string.length > 300
          string_trimmed = Domain::AlignmentReport::Views::Show::DataTrimmer.! string
          element = Element.where(id: breakout.element_id).first
          brkts << [breakout.alignment_report_id, element.label, string_trimmed, string]
        end
      end
    end

    brkts.each do |br|
      puts br.inspect
    end

    puts "\n-----------------------------------------\n\n"
    puts 'Getting editors_notes with <...'

    breakouts = Breakout.where(:editors_notes => /</).to_a

    puts "\n---------------------------------------\n\n"
    brkts = []

    breakouts.each do |breakout|
      if breakout.editors_notes
        string = breakout.editors_notes
        if string.length > 300
          string_trimmed = Domain::AlignmentReport::Views::Show::DataTrimmer.! string
          element = Element.where(id: breakout.element_id).first
          brkts << [breakout.alignment_report_id, element.label, string_trimmed, string]
        end
      end
    end

    brkts.each do |br|
      puts br.inspect
    end

    puts "\n-----------------------------------------\n\n"
    puts 'Getting aligned citations with <...'

    breakouts = Breakout.where(:pages => /</).to_a

    puts "\n---------------------------------------\n\n"
    brkts = []

    breakouts.each do |breakout|
      if breakout.pages
        string = breakout.pages
        if string.length > 300
          string_trimmed = Domain::AlignmentReport::Views::Show::DataTrimmer.! string
          element = Element.where(id: breakout.element_id).first
          brkts << [breakout.alignment_report_id, element.label, string_trimmed, string]
        end
      end
    end

    puts "\n-----------------------------------------\n\n"
    puts 'Getting non-aligned citations with <...'

    breakouts = Breakout.where(:significant_differences => /</).to_a

    puts "\n---------------------------------------\n\n"
    brkts = []

    breakouts.each do |breakout|
      if breakout.significant_differences
        string = breakout.significant_differences
        if string.length > 300
          string_trimmed = Domain::AlignmentReport::Views::Show::DataTrimmer.! string
          element = Element.where(id: breakout.element_id).first
          brkts << [breakout.alignment_report_id, element.label, string_trimmed, string]
        end
      end
    end

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end