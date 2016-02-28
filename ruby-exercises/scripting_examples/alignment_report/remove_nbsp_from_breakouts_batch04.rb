#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Remove Non-Breaking Spaces from Alignment Reports'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    i = 0
    item_num = 105001
    item_offset = 35
    offset = 1000
    limit = 1000
    times = 35

    begin
      puts "Processing breakouts..."
      breakouts = Breakout.limit(limit).skip(offset * item_offset).desc(:created_at)
      breakouts.each do |breakout|

        puts "\n---------------------------------------\n\n"
        puts "##{item_num}."
        puts breakout.id
        puts "\n----------\n\n"

        # aligned_citations 
        pages = breakout.pages.gsub("&nbsp;", " ") unless breakout.pages.nil?

        # non_aligned_citations 
        significant_differences = breakout.significant_differences.gsub("&nbsp;", " ") unless breakout.significant_differences.nil?

        # pending_citations 
        pending_message = breakout.pending_message.gsub("&nbsp;", " ") unless breakout.pending_message.nil?
        
        # reviewer_comments 
        notes = breakout.notes.gsub("&nbsp;", " ") unless breakout.notes.nil?
        
        # second_reviewer_comments
        editors_notes = breakout.editors_notes.gsub("&nbsp;", " ") unless breakout.editors_notes.nil?
        
        # publisher_comments 
        comments = breakout.comments.gsub("&nbsp;", " ") unless breakout.comments.nil?
        
        # response 
        response = breakout.response.gsub("&nbsp;", " ") unless breakout.response.nil?

        breakout.set(:pages, pages) unless breakout.pages.nil?
        breakout.set(:significant_differences, significant_differences) unless breakout.significant_differences.nil?
        breakout.set(:pending_message, pending_message) unless breakout.pending_message.nil?
        breakout.set(:notes, notes) unless breakout.notes.nil?
        breakout.set(:editors_notes, editors_notes) unless breakout.editors_notes.nil?
        breakout.set(:comments, comments) unless breakout.comments.nil?
        breakout.set(:response, response) unless breakout.response.nil?
        item_num += 1

      end

      item_offset +=1
      i +=1
    end until i == times

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end