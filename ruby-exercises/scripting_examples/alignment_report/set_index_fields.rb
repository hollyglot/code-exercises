#!/bin/env ruby
# encoding: utf-8

require_relative '../script_init'

main_title 'Set Alignment Report Index Fields'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "Setting fields..."

    ars = AlignmentReport.all.to_a

    puts "Alignments Reports: #{ars.count}\n"
    ars.each_with_index do |ar, index|
      status = ::Domain::AlignmentReport::Status::BusinessTerms.! ar.state, ar.product.state, ar.last_activity_at
      ar.set(:status_in_business_terms, status)
      sme = ar.current_sme
      ar.set(:current_sme_name, sme.name) if sme

      coverage = Domain::AlignmentReport::Commands::CalculateCoveragePercent.! ar
      ar.set(:coverage_percent, coverage.round)
      ar.set(:coverage_with_percent, "#{coverage.round}%")

      first_sme = ar.first_sme
      ar.set(:first_sme_name, first_sme.name) if first_sme

      second_sme = ar.second_sme
      ar.set(:second_sme_name, second_sme.name) if second_sme

      third_sme = ar.third_sme
      ar.set(:third_sme_name, third_sme.name) if third_sme

      ar.set(:product_title, ar.product.title)

      ar.set(:created_date, ar.created_at.strftime("%Y/%m/%d %I:%M %p"))

      ar.set(:standard_name, ar.alignment_template.standard.name)

      if ar.finalized?
        ar.set(:finalized_date, ar.finalized_at.strftime("%Y/%m/%d %I:%M %p"))
      end

      puts "#{index + 1}. #{ar.title}\n"
    end

    puts "\n---------------------------------------\n\n"
    puts "Finished setting fields."

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end