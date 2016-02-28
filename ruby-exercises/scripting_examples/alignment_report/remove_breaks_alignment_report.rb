#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Remove Extra Breaks from Alignment Reports'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    breakouts = Breakout.where(:notes => /(^<br> <br>?)/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count

    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with break:'

      puts note
      note_without_break = note.gsub(/(^<br> <br>?)/, '')
      puts "\n---------------------------------------\n\n"
      puts 'SME Note without break:'
      puts note_without_break

      breakout.notes = note_without_break

      puts "\n---------------------------------------\n\n"
      puts 'Saving Breakout with break removed...'
      breakout.save
    end

    breakouts = Breakout.where(:notes => /(^<br><br><br>?)/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count

    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with break:'

      puts note
      note_without_break = note.gsub(/(^<br><br><br>?)/, '')
      puts "\n---------------------------------------\n\n"
      puts 'SME Note without break:'
      puts note_without_break

      breakout.notes = note_without_break

      puts "\n---------------------------------------\n\n"
      puts 'Saving Breakout with break removed...'
      breakout.save
    end

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

    breakouts = Breakout.where(:notes => /(^<br><br>?)/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count

    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with break:'

      puts note
      note_without_break = note.gsub(/(^<br><br>?)/, '')
      puts "\n---------------------------------------\n\n"
      puts 'SME Note without break:'
      puts note_without_break

      breakout.notes = note_without_break

      puts "\n---------------------------------------\n\n"
      puts 'Saving Breakout with break removed...'
      breakout.save
    end

    breakouts = Breakout.where(:notes => /(^<br>?)/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count

    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with break:'

      puts note
      note_without_break = note.gsub(/(^<br>?)/, '')
      puts "\n---------------------------------------\n\n"
      puts 'SME Note without break:'
      puts note_without_break

      breakout.notes = note_without_break

      puts "\n---------------------------------------\n\n"
      puts 'Saving Breakout with break removed...'
      breakout.save
    end


    puts "\n-----------------------------------------\n\n"
    puts 'Getting Breakouts beginning with &nbsp...'

    breakouts = Breakout.where(:notes => /(^&nbsp;)/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count

    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with &nbsp;:'

      puts note
      note_without_amp = note.gsub(/(^&nbsp;)/, '')
      puts "\n---------------------------------------\n\n"
      puts 'SME Note without &nbsp;:'
      puts note_without_amp

      breakout.notes = note_without_amp

      puts "\n---------------------------------------\n\n"
      puts 'Saving Breakout with &nbsp; removed...'
      breakout.save
    end

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end