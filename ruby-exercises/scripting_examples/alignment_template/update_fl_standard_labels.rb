#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Update labels on Fl Alignment Templates'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    la_ats = AlignmentTemplate.find ["5523f9a436a263580c000072", "552866ec8080f8c425000001", "55286700b16e33bb07000001", "5528670bb16e33d9f5000068", "552c33363864ebc6e0000001", "552d466d7d49eb8e0e000027"]

    la_ats.each_with_index do |la, index|
      puts "Updating alignment template ##{index+1} of #{la_ats.count}..."
      elements = Element.where(:alignment_template_id => la.id)
      elements.each do |element|
        element.set(:label, "LAFS.#{element.label}")
      end
      puts "\n---------------------------------------\n\n"
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished setting LAFS. labels."
    puts "\n---------------------------------------\n\n"


    ma_ats = AlignmentTemplate.find ["553169e3f1718ba857000009", "5542ac7256bde5595b000001", "5542ac7bc23e16b0c3000001", "55566b89f78de2e664000013", "555678f9f78de2cc20000049", "555a1828d7b813edff000001", "555a27f54918706a12000001", "555a3108491870f1fb000040", "555a3a74d7b81322d200003a", "555a41ab4918703af400007b", "555a48454918704bf30000e0"]


    ma_ats.each_with_index do |ma, index|
      puts "Updating alignment template ##{index+1} of #{ma_ats.count}..."
      elements = Element.where(:alignment_template_id => ma.id)
      elements.each do |element|
        element.set(:label, "MAFS.#{element.label}")
      end
      puts "\n---------------------------------------\n\n"
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished setting MAFS. labels."
    puts "\n---------------------------------------\n\n"

  end
end