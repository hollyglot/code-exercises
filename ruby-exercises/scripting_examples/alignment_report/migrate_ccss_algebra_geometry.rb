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

    geometry = AlignmentTemplate.where(title: "CCSS Math (Geometry)  2015").first

    puts "\n---------------------------------------\n\n"
    puts "Creating breakouts for Geometry template alignment reports"
    geometry.alignment_reports.each do |alignment_report|
      create_breakouts(alignment_report)
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished creating breakouts for Geometry alignment reports."


    geometry_products = Product.find ["5122548af983f5aa3b00014b", "511f9dd7f983f5aa3b000036", "53ff826a17bc1e3567000004", "52d5aa10f983f546cb0020f8"]

    puts "\n---------------------------------------\n\n"
    puts "Creating alignment reports for Geometry products"

    geometry_products.each do |product|
      math_ar = product.alignment_reports.first

      geometry_ar = product.alignment_reports.build
      geometry_ar.alignment_template = geometry
      geometry_ar.save

      puts "\n\nProduct: #{product.title}"
      puts "Copying Math AR for Geometry"
      copy_alignment_report(math_ar, geometry_ar)
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished creating alignment reports for Geometry products."

    algebra_i = AlignmentTemplate.where(title: "CCSS Algebra I").first

    puts "\n---------------------------------------\n\n"
    puts "Creating breakouts for Algebra I template alignment reports"
    algebra_i.alignment_reports.each do |alignment_report|
      create_breakouts(alignment_report)
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished creating breakouts for Algebra I alignment reports."


    algebra_I_products = Product.find ["53f646c702f1dc96c100002e", "531a5266f983f5c59a000066", "52d5a73df983f516f0002ca3", "511f9a70f983f5aa3b000027", "5122513af983f5aa3b00011b"]

    puts "\n---------------------------------------\n\n"
    puts "Creating alignment reports for Algebra I products"

    algebra_I_products.each do |product|
      math_ar = product.alignment_reports.first

      algebra_I_ar = product.alignment_reports.build
      algebra_I_ar.alignment_template = algebra_i
      algebra_I_ar.save

      puts "\n\nProduct: #{product.title}"
      puts "Copying Math AR"
      copy_alignment_report(math_ar, algebra_I_ar)
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished creating alignment reports for Algebra I products."

    algebra_II_products = Product.find ["53ff826a17bc1eff78000002", "511f9c75f983f5c374000012", "512252b5f983f5aa3b000144"]

    algebra_ii = AlignmentTemplate.where(title: "CCSS Algebra II").first

    puts "\n---------------------------------------\n\n"
    puts "Creating breakouts for Algebra II template alignment reports"
    algebra_ii.alignment_reports.each do |alignment_report|
      create_breakouts(alignment_report)
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished creating breakouts for Algebra II alignment reports."

    puts "\n---------------------------------------\n\n"
    puts "Creating alignment reports for Algebra II products"

    algebra_II_products.each do |product|
      algebra_I_ar = product.alignment_reports.first

      algebra_II_ar = product.alignment_reports.build
      algebra_II_ar.alignment_template = algebra_ii
      algebra_II_ar.save

      puts "\n\nProduct: #{product.title}"
      puts "Copying Algebra I"
      copy_alignment_report(algebra_I_ar, algebra_II_ar)
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished creating alignment reports for Algebra II products."

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end