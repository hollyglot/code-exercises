#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Migrate Existing Alignment Reports to Florida Standards'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    def copy_alignment_report(original_ar, new_alignment)
      new_ar = AlignmentReport.where(id: new_alignment.id).first
      if new_ar.breakouts.empty?
        sleep(5)
      end

      original_breakouts = original_ar.breakouts

      new_ar.breakouts.each do |new_ar_breakout|
        element_II = new_ar_breakout.element
        if element_II
          original_breakouts.each do |old_ar_breakout|
            element_I = old_ar_breakout.element

            if element_I 
              element_I_content = Nokogiri::HTML::DocumentFragment.parse(element_I.content).text.gsub("\n", " ")
              element_II_content = Nokogiri::HTML::DocumentFragment.parse(element_II.content).text.gsub("\n", " ")
              if element_I_content.include? element_II_content
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
    end

    ccss_products = ["53fa12bcec7f0185c8000002", "53fa161aec7f0185c800000a", "53e8e0ef830b2bee8300002d", "53fa1762ec7f0185c8000012", "53fa18f2ec7f0185c800001a", "53fa1a01ec7f0185c8000022"]
    fl_products = ["559ff01142fd8bc614000002", "559fefef74ec3c15cd000018", "559ff01774ec3c4615000045", "559feff774ec3c14e7000024", "559ff00274ec3c461500002f", "559fefe374ec3ceb7e00000d"]

    fl_standard = Standard.find "55147666ef1c775b08000106"

    puts "\n---------------------------------------\n\n"
    puts "Creating alignment reports."

    (0..5).each do |index|
      ccss_product = Product.find ccss_products[index]
      orig_ar = ccss_product.alignment_reports.last

      subject = ccss_product.first_component.subject.title
      grade = orig_ar.grade

      alignment_template = AlignmentTemplate.all_of(:grade => grade, :subject => subject, :standard_id => fl_standard.id).first

      new_product = Product.find fl_products[index]
      new_ar = new_product.alignment_reports.build
      new_ar.alignment_template = alignment_template
      new_ar.title = orig_ar.title.gsub("CCSS", "FL")
      new_ar.save

      puts "\n\nProduct: #{ccss_product.title}"
      puts "Copying AR"
      copy_alignment_report(orig_ar, new_ar)
    end


    puts "\n---------------------------------------\n\n"
    puts "Finished migrating alignment reports."


    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end