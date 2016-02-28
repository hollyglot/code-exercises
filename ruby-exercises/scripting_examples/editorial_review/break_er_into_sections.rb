#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Break Editorial Review into Sections'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "All:"
    puts ProductReview.count


    ############################   SET INTRO   ###################################

    ers = ProductReview.all


    puts "\n---------------------------------------\n\n"

    ers.each do |er|
      intro = er.preview

      puts "\n---------------------------------------\n\n"
      puts 'Updating ER preview to intro'

      puts intro

      er.set(:intro, intro)

      puts "\n---------------------------------------\n\n"
    end


    # ####################################   Break Sections  ##########################

    ers = ProductReview.all

    strengthsAry = []
    goodAry = []
    techAry = []
    contentAry = []
    easeAry = []
    mtAry = []
    assessAry = []
    whoAry = []
    pubAry = []

    ers.each do |er|
      review = er.final_review

      puts er.id

      # Remove returns, new lines, and tabs
      if review
        result = 'remove \r'
        until result == nil
          result = review.slice!(/\r/)
        end
        result = 'remove \n'
        until result == nil
          result = review.slice!(/\n/)
        end
        result = 'remove \t'
        until result == nil
          result = review.slice!(/\t/)
        end

        # Remove break style
        review = review.gsub('<br style="color:rgb(51, 51, 51);line-height:20.799999237060547px;" />', '<br>')

        puts "\n---------------------------------------\n\n"
        puts 'Product Strengths'

        review = review.gsub('<strong style="color:rgb(51, 51, 51);line-height:20.799999237060547px;">', '<strong>')
        review = review.gsub('<strong style="color: rgb(51, 51, 51); font-family: sans-serif, Arial, Verdana, \'Trebuchet MS\'; font-size: 13px; line-height: 20.799999237060547px;">', '<strong>')
        # use regex to grab everything between title of section and title of next section
        ps = /(?<=Product Strengths<\/strong>)(.*)(?=<strong>Good)/.match(review)

        if ps
          product_strength = ps.to_s.strip
          result = 'remove <br>'
          until result == nil
            result = product_strength.to_s.slice!(/^<br \\>|<br \\>$/)
          end
          until result == nil
            result = product_strength.slice!(/^<br>|<br>$/)
          end

          puts product_strength
          strengthsAry << product_strength
        end

        er.set(:strengths, product_strength)

        puts "\n---------------------------------------\n\n"
        puts 'Good to Know'

        review = review.gsub('<strong style="line-height: 1.6em;">', '<strong>')
        # use regex to grab everything between title of section and title of next section
        review = review.gsub('</strong><strong>Know</strong>', 'Know</strong>')
        gtk = /(?<=Good to Know<\/strong>)(.*)(?=<strong>Technology)/.match(review)

        if gtk
          good = gtk.to_s.strip

          result = 'remove <br>'
          until result == nil
            result = good.slice!(/^<br \\>|<br \\>$/)
          end
          until result == nil
            result = good.slice!(/^<br>|<br>$/)
          end

          puts good
          goodAry << good
        end

        er.set(:good_to_know, good)

        puts "\n---------------------------------------\n\n"
        puts 'Technology Requirements'

        review = review.gsub('<br style="color:rgb(51, 51, 51);line-height:20.799999237060547px;" />', '<br \\>')
        review = review.gsub('<strong style="color:rgb(51, 51, 51);line-height:1.6em;">', '<strong>')

        # use regex to grab everything between title of section and title of next section
        tech = /(?<=Technology Requirements<\/strong>)(.*)(?=<strong>Instructional Content)/.match(review)

        unless tech
          tech = /(?<= <\/strong>)(.*)(?=<strong>Instructional Content)/.match(review)
        end

        if tech
          technology = tech.to_s.strip

          result = 'remove <br>'
          until result == nil
            result = technology.slice!(/^<br \\>|<br \\>$/)
          end
          until result == nil
            result = technology.slice!(/^<br>|<br>$/)
          end

          puts technology
          techAry << technology
        end

        er.set(:technology_requirements, technology)

        puts "\n---------------------------------------\n\n"
        puts 'Instructional Content'

        # use regex to grab everything between title of section and title of next section
        instruct = /(?<=Instructional Content<\/strong>)(.*)(?=<strong>Instructional)/.match(review)

        unless instruct
          instruct = /(?<=Instructional Content<\/strong>)(.*)(?=<strong>Product)/.match(review)
        end

        unless instruct
          instruct = /(?<=    <\/strong>)(.*)(?=<strong>Instructional Design)/.match(review)
        end

        unless instruct
          instruct = /(?<=Content and Product Design<\/strong>)(.*)(?=<strong>Ease)/.match(review)
        end

        if instruct
          instructional = instruct.to_s.strip

          result = 'remove <br>'
          until result == nil
            result = instructional.slice!(/^<br \\>|<br \\>$/)
          end
          until result == nil
            result = instructional.slice!(/^<br>|<br>$/)
          end

          puts instructional
          contentAry << instructional
        end

        er.set(:instructional_content, instructional)

        puts "\n---------------------------------------\n\n"
        puts 'Ease of Use'

        review = review.gsub('<strong> Monitoring', '<strong>Monitoring')
        review = review.gsub('Ease of Use </strong>', 'Ease of Use</strong>')
        review = review.gsub('Ease of Use             </strong>', 'Ease of Use</strong>')

        # use regex to grab everything between title of section and title of next section
        ease = /(?<=Ease of Use<\/strong>)(.*)(?=<strong>Monitoring)/.match(review)

        if ease
          ease_of_use = ease.to_s.strip
          result = 'remove <br>'
          until result == nil
            result = ease_of_use.slice!(/^<br \\>|<br \\>$/)
          end
          until result == nil
            result = ease_of_use.slice!(/^<br>|<br>$/)
          end

          puts ease_of_use
          easeAry << ease_of_use
        end

        er.set(:ease_of_use, ease_of_use)

        puts "\n---------------------------------------\n\n"
        puts 'Monitoring Tools'

          review = review.gsub('Tools             </strong>', 'Tools</strong>')
          review = review.gsub('Tools </strong>', 'Tools</strong>')
          review = review.gsub('Tools<br />             </strong>', 'Tools</strong>')
          review = review.gsub('Tools     <br />        </strong>', 'Tools</strong>')
          review = review.gsub('<strong>Assessment</strong>', '<strong>Assessments</strong>')

        # use regex to grab everything between title of section and title of next section
        mt = /(?<=Monitoring Tools<\/strong>)(.*)(?=<strong>Assessments)/.match(review)

        if mt
          monitoring = mt.to_s.strip
          result = 'remove <br>'
          until result == nil
            result = monitoring.slice!(/^<br \\>|<br \\>$/)
          end
          until result == nil
            result = monitoring.slice!(/^<br>|<br>$/)
          end

          puts monitoring

          mtAry << monitoring
        end

        er.set(:monitoring_tools, monitoring)

        puts "\n---------------------------------------\n\n"
        puts 'Assessments'

        review = review.gsub('<strong>Assessments</strong>: ', '<strong>Assessments</strong>')

        # use regex to grab everything between title of section and title of next section
        ast = /(?<=<strong>Assessments<\/strong>)(.*)(?=<strong>Who)/.match(review)

        if ast
          assess = ast.to_s.strip
          result = 'remove <br>'
          until result == nil
            result = assess.slice!(/^<br \\>|<br \\>$/)
          end
          until result == nil
            result = assess.slice!(/^<br>|<br>$/)
          end

          puts assess

          assessAry << assess
        end

        er.set(:assessments, assess)

        puts "\n---------------------------------------\n\n"
        puts "Who's Using"

        review = review.gsub('<strong style="line-height: 20px; outline: none !important;">', '<strong>')
        review = review.gsub('<strong style="line-height:20px;outline:none !important;">', '<strong>')

        # use regex to grab everything between title of section and title of next section
        who = /(?<=Product\?<\/strong>)(.*)(?=<strong>Publisher)/.match(review)

        if who
          users = who.to_s.strip
          result = 'remove <br>'
          until result == nil
            result = users.slice!(/^<br \\>|<br \\>$/)
          end
          until result == nil
            result = users.slice!(/^<br>|<br>$/)
          end

          puts users

          whoAry << users
        end

        er.set(:product_users, users)

        puts "\n---------------------------------------\n\n"

        puts 'Questionnaire'

        # use regex to grab everything between title of section and title of next section
        question = /(Learning List asks each publisher.*)/.match(review)

        if question
          questionnaire = question.to_s.strip
          result = 'remove <br>'
          until result == nil
            result = questionnaire.slice!(/^<br \\>|<br \\>$/)
          end
          until result == nil
            result = questionnaire.slice!(/^<br>|<br>$/)
          end

          puts questionnaire
          pubAry << questionnaire
        end

        er.set(:publisher_questionnaire, questionnaire)

        puts "\n---------------------------------------\n\n"
      end
    end

    puts "Total Strengths:"
    puts strengthsAry.length

    puts "Total GTK:"
    puts goodAry.length

    puts "Total Tech Requirements:"
    puts techAry.length

    puts "Total Instructional Content:"
    puts contentAry.length

    puts "Total Ease of Use:"
    puts easeAry.length

    puts "Total Monitoring:"
    puts mtAry.length

    puts "Total Assessments:"
    puts assessAry.length

    puts "Total Who's Using:"
    puts whoAry.length

    puts "Total Questionnaire:"
    puts pubAry.length

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end