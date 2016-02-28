#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Migrate CCSS Algebra I, II and Geometry to New Templates'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    def copy_alignment_report(original_ar, new_alignment)
      new_ar = AlignmentReport.where(id: new_alignment.id).first
      if new_ar.breakouts.empty?
        sleep(5)
      end
      new_ar.breakouts.each do |new_ar_breakout|
        element_II = new_ar_breakout.element
        if element_II
          original_ar.breakouts.each do |old_ar_breakout|
            element_I = old_ar_breakout.element
            if element_I && element_I.content == element_II.content
              new_ar_breakout.publisher_alignment = old_ar_breakout.publisher_alignment
              new_ar_breakout.pages = old_ar_breakout.pages
              new_ar_breakout.addressed = old_ar_breakout.addressed
              new_ar_breakout.notes = old_ar_breakout.notes
              new_ar_breakout.pending_message = old_ar_breakout.pending_message
              new_ar_breakout.comments = old_ar_breakout.comments
              new_ar_breakout.significant_differences = old_ar_breakout.significant_differences
              new_ar_breakout.editors_notes = old_ar_breakout.editors_notes
              new_ar_breakout.save
            elsif element_I && "#{element_I.label} #{element_I.content}" == element_II.content
              new_ar_breakout.publisher_alignment = old_ar_breakout.publisher_alignment
              new_ar_breakout.pages = old_ar_breakout.pages
              new_ar_breakout.addressed = old_ar_breakout.addressed
              new_ar_breakout.notes = old_ar_breakout.notes
              new_ar_breakout.pending_message = old_ar_breakout.pending_message
              new_ar_breakout.comments = old_ar_breakout.comments
              new_ar_breakout.significant_differences = old_ar_breakout.significant_differences
              new_ar_breakout.editors_notes = old_ar_breakout.editors_notes
              new_ar_breakout.save              
            end
          end
        end
      end
    end

    def create_breakouts(alignment_report)
      alignment_report.alignment_template.elements.without_children.each do |element|
        breakout_exists = alignment_report.breakouts.where(element_id: element.id).first
        unless breakout_exists
          breakout = element.breakouts.build
          alignment_report.breakouts << breakout
        end
      end
      alignment_report.save
    end

    fourth_course = AlignmentTemplate.find '559e9f1a178fbce207000001'

    puts "\n---------------------------------------\n\n"
    puts "Creating breakouts for fourth course template alignment reports"
    fourth_course.alignment_reports.each do |alignment_report|
      create_breakouts(alignment_report)
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished creating breakouts for Fourth Course alignment reports."

    # products that need to have ARs migrated
    fourth_course_products = Product.find ["511fa0c1f983f5c374000027", "52d5a94cf983f516f0002caf", "548b0a465fa6f7bd1e000081"]

    puts "\n---------------------------------------\n\n"
    puts "Creating alignment reports for Fourth Course products"

    fourth_course_products.each do |product|
      # old report
      math_ar = product.alignment_reports.first
      # create new report as a clone of old report object
      fourth_course_ar = math_ar.clone
      fourth_course_ar.alignment_template = fourth_course
      # prevent ar controller from sending notification email to SMEs
      fourth_course_ar.first_sme_id = nil
      fourth_course_ar.second_sme_id = nil
      fourth_course_ar.third_sme_id = nil
      fourth_course_ar.save

      # set SMEs (no notification email sent)
      fourth_course_ar.set(:first_sme_id, math_ar.first_sme_id)
      fourth_course_ar.set(:second_sme_id, math_ar.second_sme_id)
      fourth_course_ar.set(:third_sme_id, math_ar.third_sme_id)

      puts "\n\nProduct: #{product.title}"
      puts "Copying HS Math AR for Fourth Course"
      copy_alignment_report(math_ar, fourth_course_ar)
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished creating alignment reports for CCSS Math Fourth Course products."


    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end