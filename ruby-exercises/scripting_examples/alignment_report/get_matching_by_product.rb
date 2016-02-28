#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Get Matching ARs by Product'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do
    def match_alignment_template(products, at_ids=nil)
      if at_ids.nil?
        set_at_ids = true
        at_ids = []
      end

      matching_ars = []
      products.each_with_index do |product, index|
        if at_ids.length > 0
          matching_ars << product.alignment_reports.select { |ar| at_ids.include? ar.alignment_template_id } if product
          matching_ars = matching_ars.flatten.uniq
          at_ids << product.alignment_reports.map { |ar| ar.alignment_template_id } if product && set_at_ids
          at_ids = at_ids.flatten.uniq
        else
          at_ids << product.alignment_reports.map { |ar| ar.alignment_template_id } if product && set_at_ids
          at_ids = at_ids.flatten.uniq
          matching_ars << product.alignment_reports.select { |ar| at_ids.include? ar.alignment_template_id } if product && index > 0
          matching_ars = matching_ars.flatten.uniq
        end
        
        puts "\n---------------------------------------\n\n"
        puts "Matched:"
        puts matching_ars.inspect

        puts "AT IDS"
        puts at_ids
      end

      if matching_ars.length > 0
        puts "\n---------------------------------------\n\n"
        puts "Matchy match:"
        puts matching_ars.inspect
        matching_ars
      else
        false
      end
    end
    
    def get_alignment_reports(products)
      matching_ars = match_alignment_template(products)

      if matching_ars
        at_ids = [matching_ars[0].alignment_template_id]
        matching_ars = match_alignment_template(products, at_ids)
        return matching_ars
      else
        return false
      end
    end


    products = Product.find("5282fb40f983f51a0b0000ea", "52d431cef983f53e1d002516", "5294e1c3f983f53a5f000021")

    puts "products:\n"
    puts products.inspect
    matching_ars = get_alignment_reports(products)

    if matching_ars
      puts "Final Matching!"
      puts matching_ars.inspect
    end

    matching_ars2 = Domain::AlignmentReport::Queries::MatchingAlignmentTemplateByProduct.! products

    if matching_ars2
      puts "Final Matching 2!"
      puts matching_ars2.inspect
      puts matching_ars2.length
    end
    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end