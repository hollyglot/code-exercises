#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Remove Due Too Statement from Alignment Report'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n-----------------------------------------\n\n"
    puts 'Getting Breakouts with Due to statment...'

    breakouts = Breakout.where(:notes => /Due to/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count

    due_to = []

    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with Due To:'
      due_to << note[/([A-Z][^.?!]*?)?(?<!\\w)(?i)(due)(?!\\w)[^.?!]*?[.?!]/]

      puts note
      note_without_due_to = note.gsub(/([A-Z][^.?!]*?)?(?<!\\w)(?i)(due)(?!\\w)[^.?!]*?[.?!]/, '')
      puts "\n---------------------------------------\n\n"
      puts 'SME Note without Due To:'
      puts note_without_due_to

      breakout.notes = note_without_due_to

      puts "\n---------------------------------------\n\n"
      puts 'Saving Breakout with due to removed...'
      breakout.save
    end

    due_to.uniq!

    puts due_to.count
    puts due_to.inspect

    puts "\n-----------------------------------------\n\n"
    puts 'Getting Breakouts with Due to statment...'

    breakouts = Breakout.where(:notes => /Due to/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count

    due_to = []

    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with Due To:'
      due_to << note[/(Due)?(\w*)(\W)/]

      puts note
      note_without_due_to = note.gsub(/(Due)?(\w*)(\W)/, '')
      puts "\n---------------------------------------\n\n"
      puts 'SME Note without Due To:'
      puts note_without_due_to

      breakout.notes = note_without_due_to

      puts "\n---------------------------------------\n\n"
      puts 'Saving Breakout with due to removed...'
      breakout.save
    end

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

    puts "\n-----------------------------------------\n\n"
    puts 'Getting Breakouts with extra breaks...'

    breakouts = Breakout.where(:notes => /<br><br><br><br>/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count


    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with breaks:'

      puts note
      note_without_breaks = note.gsub(/<br><br><br><br>/, '<br><br>')
      puts "\n---------------------------------------\n\n"
      puts 'SME Note without break:'
      puts note_without_breaks

      breakout.notes = note_without_breaks

      puts "\n---------------------------------------\n\n"
      puts 'Saving Breakout with breaks removed...'
      breakout.save
    end

    puts "\n-----------------------------------------\n\n"
    puts 'Getting Breakouts with extra p tags...'

    breakouts = Breakout.where(:notes => /<p><br><\/p>/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count

    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with p tag:'

      puts note
      note_without_p = note.gsub(/<p><br><\/p>/, '')
      puts "\n---------------------------------------\n\n"
      puts 'SME Note without p tag:'
      puts note_without_p

      breakout.notes = note_without_p

      puts "\n---------------------------------------\n\n"
      puts 'Saving Breakout with p tag removed...'
      breakout.save
    end

    puts "\n-----------------------------------------\n\n"
    puts 'Getting Breakouts beginning with break...'

    breakouts = Breakout.where(:notes => /(^<br><br>?)|(^<br>?)/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count

    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with break:'

      puts note
      note_without_break = note.gsub(/(^<br><br>?)|(^<br>?)/, '')
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

    puts "\n-----------------------------------------\n\n"
    puts 'Getting Breakouts beginning with alignment...'

    breakouts = Breakout.where(:notes => /(^alignment)/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count

    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with alignment:'

      puts note
      note_without_alignment = note.gsub(/(^alignment)/, '')
      puts "\n---------------------------------------\n\n"
      puts 'SME Note without alignment:'
      puts note_without_alignment

      breakout.notes = note_without_alignment

      puts "\n---------------------------------------\n\n"
      puts 'Saving Breakout with alignment removed...'
      breakout.save
    end

    puts "\n-----------------------------------------\n\n"
    puts 'Getting Breakouts with extra strong tag...'

    breakouts = Breakout.where(:notes => /(^<strong><\/strong>)/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count

    breakouts.each do |breakout|
      note = breakout.notes

      puts "\n---------------------------------------\n\n"
      puts 'SME Note with extra strong tag:'

      puts note
      note_without_strong = note.gsub(/(^<strong><\/strong>)/, '')
      puts "\n---------------------------------------\n\n"
      puts 'SME Note without strong tag:'
      puts note_without_strong

      breakout.notes = note_without_strong

      puts "\n---------------------------------------\n\n"
      puts 'Saving Breakout with strong tag removed...'
      breakout.save
    end


    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end