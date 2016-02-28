#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Update PQ Links to Amazon S3'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "All:"
    puts ProductReview.count

    ers = ProductReview.where(:final_review => /https:\/\/learninglist.com\/system\/downloads/).to_a


    puts "\n---------------------------------------\n\n"
    puts 'Number of Editorial Reviews with https:'
    puts ers.count

    ers.each do |er|
      review = er.final_review

      puts "\n---------------------------------------\n\n"
      puts 'Updating PQ link...'

      updated_review = review.gsub(/https:\/\/learninglist.com\/system\/downloads/, 'https://s3.amazonaws.com/ll406/downloads')
      puts "\n---------------------------------------\n\n"

      updated_end = updated_review[-250..-1] || updated_review
      puts 'Updated PQ Link:'
      puts updated_end


      er.final_review = updated_review

      puts "\n---------------------------------------\n\n"
      puts 'Saving Editorial Review...'

      er.save
    end

    ers = ProductReview.where(:final_review => /http:\/\/learninglist.com\/system\/downloads/).to_a


    puts "\n---------------------------------------\n\n"
    puts 'Number of Editorial Reviews with http:'
    puts ers.count

    ers.each do |er|
      review = er.final_review

      puts "\n---------------------------------------\n\n"
      puts 'Updating PQ link...'

      updated_review = review.gsub(/http:\/\/learninglist.com\/system\/downloads/, 'https://s3.amazonaws.com/ll406/downloads')
      puts "\n---------------------------------------\n\n"

      updated_end = updated_review[-250..-1] || updated_review
      puts 'Updated PQ Link:'
      puts updated_end

      er.final_review = updated_review

      puts "\n---------------------------------------\n\n"
      puts 'Saving Editorial Review...'

      er.save
    end

    ers = ProductReview.where(:final_review => /https:\/\/www.learninglist.com\/system\/downloads/).to_a


    puts "\n---------------------------------------\n\n"
    puts 'Number of Editorial Reviews with https://www:'
    puts ers.count

    ers.each do |er|
      review = er.final_review

      puts "\n---------------------------------------\n\n"
      puts 'Updating PQ link...'

      updated_review = review.gsub(/https:\/\/www.learninglist.com\/system\/downloads/, 'https://s3.amazonaws.com/ll406/downloads')
      puts "\n---------------------------------------\n\n"

      updated_end = updated_review[-250..-1] || updated_review
      puts 'Updated PQ Link:'
      puts updated_end

      er.final_review = updated_review

      puts "\n---------------------------------------\n\n"
      puts 'Saving Editorial Review...'

      er.save
    end

    ers = ProductReview.where(:final_review => /http:\/\/www.learninglist.com\/system\/downloads/).to_a


    puts "\n---------------------------------------\n\n"
    puts 'Number of Editorial Reviews with http://www:'
    puts ers.count

    ers.each do |er|
      review = er.final_review

      puts "\n---------------------------------------\n\n"
      puts 'Updating PQ link...'

      updated_review = review.gsub(/http:\/\/www.learninglist.com\/system\/downloads/, 'https://s3.amazonaws.com/ll406/downloads')
      puts "\n---------------------------------------\n\n"

      updated_end = updated_review[-250..-1] || updated_review
      puts 'Updated PQ Link:'
      puts updated_end

      er.final_review = updated_review

      puts "\n---------------------------------------\n\n"
      puts 'Saving Editorial Review...'

      er.save
    end

    ers = ProductReview.where(:final_review => /www.learninglist.com\/system\/downloads/).to_a


    puts "\n---------------------------------------\n\n"
    puts 'Number of Editorial Reviews with www:'
    puts ers.count

    ers.each do |er|
      review = er.final_review

      puts "\n---------------------------------------\n\n"
      puts 'Updating PQ link...'

      updated_review = review.gsub(/www.learninglist.com\/system\/downloads/, 'https://s3.amazonaws.com/ll406/downloads')
      puts "\n---------------------------------------\n\n"

      updated_end = updated_review[-250..-1] || updated_review
      puts 'Updated PQ Link:'
      puts updated_end

      er.final_review = updated_review

      puts "\n---------------------------------------\n\n"
      puts 'Saving Editorial Review...'

      er.save
    end

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end