#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Break Editorial Review into Sections'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    editorial_reviews = ProductReview.all
    num_products = editorial_reviews.count


   ############################   INTRO   ###################################
    puts "Working on intro sections..."
    puts "\n======================================\n\n"

    editorial_reviews.each do |er|
      if er.intro
        intro = er.intro
        puts intro
        result = 'remove leading breaks'
        until result == nil
          result = intro.slice!(/^<br \/>/)
        end
        result = 'remove trailing breaks'
        until result == nil
          result = intro.slice!(/<br \/>$/)
        end
        puts "No more leading or trailing breaks!:"
        puts intro
      else
        puts er.inspect
      end
      puts "\n---------------------------------------\n\n"
    end


    ####################################   STRENGTHS  ##########################

    puts "Working on strengths sections..."
    puts "\n======================================\n\n"

    i = 0

    editorial_reviews.each do |er|
      if er.strengths
        strengths = er.strengths
        puts strengths

        result = 'remove leading breaks'
        until result == nil
          result = strengths.slice!(/^<br \/>/)
        end

        result = 'remove more leading breaks'
        until result == nil
          result = strengths.slice!(/^<br>/)
        end

        result = 'remove trailing breaks'
        until result == nil
          result = strengths.slice!(/<br \/>$/)
        end

        result = 'remove more trailing breaks'
        until result == nil
          result = strengths.slice!(/<br>$/)
        end

        #remove leading and trailing whitespace
        strengths.strip!
        puts "No more leading or trailing breaks!:"
        puts strengths
        er.set(:strengths, strengths)
        i = i+1
      end
      puts "\n---------------------------------------\n\n"
    end

    puts "Finished with strengths. #{i} out of #{num_products} products updated."

    ####################################   Publisher Questionnaire  ##########################

    puts "Working on Publisher Questionnaire sections..."
    puts "\n======================================\n\n"

    i = 0

    editorial_reviews.each do |er|
      if er.publisher_questionnaire
        publisher_questionnaire = er.publisher_questionnaire
        puts publisher_questionnaire

        result = 'remove leading breaks'
        until result == nil
          result = publisher_questionnaire.slice!(/^<br \/>/)
        end

        result = 'remove more leading breaks'
        until result == nil
          result = publisher_questionnaire.slice!(/^<br>/)
        end

        result = 'remove trailing breaks'
        until result == nil
          result = publisher_questionnaire.slice!(/<br \/>$/)
        end

        result = 'remove more trailing breaks'
        until result == nil
          result = publisher_questionnaire.slice!(/<br>$/)
        end
        #remove leading and trailing whitespace
        publisher_questionnaire.strip!
        puts "No more leading or trailing breaks!:"
        puts publisher_questionnaire
        er.set(:publisher_questionnaire, publisher_questionnaire)
        puts er.inspect
        i = i+1
      end
      puts "\n---------------------------------------\n\n"
    end

    puts "Finished with publisher_questionnaire. #{i} out of #{num_products} products updated."

    ####################################   Product Users  ##########################

    puts "Working on Product Users sections..."
    puts "\n======================================\n\n"

    i = 0

    editorial_reviews.each do |er|
      if er.product_users
        product_users = er.product_users
        puts product_users

        result = 'remove leading breaks'
        until result == nil
          result = product_users.slice!(/^<br \/>/)
        end

        result = 'remove more leading breaks'
        until result == nil
          result = product_users.slice!(/^<br>/)
        end

        result = 'remove trailing breaks'
        until result == nil
          result = product_users.slice!(/<br \/>$/)
        end

        result = 'remove more trailing breaks'
        until result == nil
          result = product_users.slice!(/<br>$/)
        end
        #remove leading and trailing whitespace
        product_users.strip!
        puts "No more leading or trailing breaks!:"
        puts product_users
        er.set(:product_users, product_users)
        puts er.inspect
        i = i+1
      end
      puts "\n---------------------------------------\n\n"
    end

    puts "Finished with product_users. #{i} out of #{num_products} products updated."

    ###################################   Monitoring Tools  ##########################

    puts "Working on Monitoring Tools sections..."
    puts "\n======================================\n\n"

    i = 0

    editorial_reviews.each do |er|
      if er.monitoring_tools
        monitoring_tools = er.monitoring_tools
        puts monitoring_tools

        result = 'remove leading breaks'
        until result == nil
          result = monitoring_tools.slice!(/^<br \/>/)
        end

        result = 'remove more leading breaks'
        until result == nil
          result = monitoring_tools.slice!(/^<br>/)
        end

        result = 'remove trailing breaks'
        until result == nil
          result = monitoring_tools.slice!(/<br \/>$/)
        end

        result = 'remove more trailing breaks'
        until result == nil
          result = monitoring_tools.slice!(/<br>$/)
        end
        #remove leading and trailing whitespace
        monitoring_tools.strip!
        puts "No more leading or trailing breaks!:"
        puts monitoring_tools
        er.set(:monitoring_tools, monitoring_tools)
        puts er.inspect
        i = i+1
      end
      puts "\n---------------------------------------\n\n"
    end

    puts "Finished with monitoring_tools. #{i} out of #{num_products} products updated."

    ###################################   Instructional Content  ##########################

    puts "Working on Instructional Content sections..."
    puts "\n======================================\n\n"

    i = 0

    editorial_reviews.each do |er|
      if er.instructional_content
        instructional_content = er.instructional_content
        puts instructional_content

        result = 'remove leading breaks'
        until result == nil
          result = instructional_content.slice!(/^<br \/>/)
        end

        result = 'remove more leading breaks'
        until result == nil
          result = instructional_content.slice!(/^<br>/)
        end

        result = 'remove trailing breaks'
        until result == nil
          result = instructional_content.slice!(/<br \/>$/)
        end

        result = 'remove more trailing breaks'
        until result == nil
          result = instructional_content.slice!(/<br>$/)
        end
        #remove leading and trailing whitespace
        instructional_content.strip!
        puts "No more leading or trailing breaks!:"
        puts instructional_content
        er.set(:instructional_content, instructional_content)
        puts er.inspect
        i = i+1
      end
      puts "\n---------------------------------------\n\n"
    end

    puts "Finished with instructional_content. #{i} out of #{num_products} products updated."

    ###################################   Good to Know  ##########################

    puts "Working on Good to Know sections..."
    puts "\n======================================\n\n"

    i = 0

    editorial_reviews.each do |er|
      if er.good_to_know
        good_to_know = er.good_to_know
        puts good_to_know

        result = 'remove leading breaks'
        until result == nil
          result = good_to_know.slice!(/^<br \/>/)
        end

        result = 'remove more leading breaks'
        until result == nil
          result = good_to_know.slice!(/^<br>/)
        end

        result = 'remove trailing breaks'
        until result == nil
          result = good_to_know.slice!(/<br \/>$/)
        end

        result = 'remove more trailing breaks'
        until result == nil
          result = good_to_know.slice!(/<br>$/)
        end
        #remove leading and trailing whitespace
        good_to_know.strip!
        puts "No more leading or trailing breaks!:"
        puts good_to_know
        er.set(:good_to_know, good_to_know)
        puts er.inspect
        i = i+1
      end
      puts "\n---------------------------------------\n\n"
    end

    puts "Finished with good_to_know. #{i} out of #{num_products} products updated."

    ###################################   Ease of Use  ##########################

    puts "Working on Ease of Use sections..."
    puts "\n======================================\n\n"

    i = 0

    editorial_reviews.each do |er|
      if er.ease_of_use
        ease_of_use = er.ease_of_use
        puts ease_of_use

        result = 'remove leading breaks'
        until result == nil
          result = ease_of_use.slice!(/^<br \/>/)
        end

        result = 'remove more leading breaks'
        until result == nil
          result = ease_of_use.slice!(/^<br>/)
        end

        result = 'remove trailing breaks'
        until result == nil
          result = ease_of_use.slice!(/<br \/>$/)
        end

        result = 'remove more trailing breaks'
        until result == nil
          result = ease_of_use.slice!(/<br>$/)
        end
        #remove leading and trailing whitespace
        ease_of_use.strip!
        puts "No more leading or trailing breaks!:"
        puts ease_of_use
        er.set(:ease_of_use, ease_of_use)
        puts er.inspect
        i = i+1
      end
      puts "\n---------------------------------------\n\n"
    end

    puts "Finished with ease_of_use. #{i} out of #{num_products} products updated."

    ###################################   Assessments  ##########################

    puts "Working on Assessments sections..."
    puts "\n======================================\n\n"

    i = 0

    editorial_reviews.each do |er|
      if er.assessments
        assessments = er.assessments
        puts assessments

        result = 'remove leading breaks'
        until result == nil
          result = assessments.slice!(/^<br \/>/)
        end

        result = 'remove more leading breaks'
        until result == nil
          result = assessments.slice!(/^<br>/)
        end

        result = 'remove trailing breaks'
        until result == nil
          result = assessments.slice!(/<br \/>$/)
        end

        result = 'remove more trailing breaks'
        until result == nil
          result = assessments.slice!(/<br>$/)
        end
        #remove leading and trailing whitespace
        assessments.strip!
        puts "No more leading or trailing breaks!:"
        puts assessments
        er.set(:assessments, assessments)
        puts er.inspect
        i = i+1
      end
      puts "\n---------------------------------------\n\n"
    end

    puts "Finished with assessments. #{i} out of #{num_products} products updated."

    ###################################   Technology Requirements  ##########################

    puts "Working on Technology Requirements sections..."
    puts "\n======================================\n\n"

    i = 0

    editorial_reviews.each do |er|
      if er.technology_requirements
        technology_requirements = er.technology_requirements
        puts technology_requirements

        result = 'remove leading breaks'
        until result == nil
          result = technology_requirements.slice!(/^<br \/>/)
        end

        result = 'remove more leading breaks'
        until result == nil
          result = technology_requirements.slice!(/^<br>/)
        end

        result = 'remove trailing breaks'
        until result == nil
          result = technology_requirements.slice!(/<br \/>$/)
        end

        result = 'remove more trailing breaks'
        until result == nil
          result = technology_requirements.slice!(/<br>$/)
        end
        #remove leading and trailing whitespace
        technology_requirements.strip!
        puts "No more leading or trailing breaks!:"
        puts technology_requirements
        er.set(:technology_requirements, technology_requirements)
        puts er.inspect
        i = i+1
      end
      puts "\n---------------------------------------\n\n"
    end

    puts "Finished with technology_requirements. #{i} out of #{num_products} products updated."

    puts 'Done!'

  end
end