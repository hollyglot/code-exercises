#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Migrate Existing Alignment Reports to New Templates'

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
            if element_I && element_I.label == element_II.label
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
      new_ar.finalize
    end


    template = AlignmentTemplate.where(title: "TEKS Math Spanish Grade K").first

    products = Product.find ["52d83804f983f53e1d00348b"]
    first_sme = SME.find '5526d0fe5b03bbc1b7000002'
    second_sme = SME.find '5424461dc3650149fd000028'

    puts "\n---------------------------------------\n\n"
    puts "Creating alignment reports."

    products.each do |product|
      orig_ar = product.alignment_reports.first

      new_ar = product.alignment_reports.build
      new_ar.alignment_template = template
      new_ar.first_sme = first_sme
      new_ar.second_sme = second_sme
      new_ar.save

      puts "\n\nProduct: #{product.title}"
      puts "Copying AR"
      copy_alignment_report(orig_ar, new_ar)
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished creating alignment reports."


    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end