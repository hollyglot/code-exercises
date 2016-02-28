require_relative '../script_init'

main_title 'Find Most Aligned Grades'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Getting TEKS Alignment Templates...\n\n"

    standard = Standard.where(name: "TEKS").first
    teks_alignment_templates = AlignmentTemplate.where(standard_id: standard.id).asc(:subject, :grade)

    teks_alignment_templates.each do |at|
      puts "\n"
      puts at.title

      alignment_coverage = []
      alignment_reports = []

      finalized_alignment_reports = at.alignment_reports.finalized

      finalized_alignment_reports.each do |ar|
        unless ar.product.first_component.small_standards_subset
          alignment_reports << ar
        end 
      end

      number_of_reports = alignment_reports.count

      unless alignment_reports.empty?
        alignment_reports.each do |alignment_report|
          # Finds parent standard and checks for aligned and non-aligned standards
          alignment_coverage << alignment_report.coverage_percent
        end

        alignment_total = alignment_coverage.inject{|sum,x| sum + x }

        alignment_average = alignment_total / number_of_reports

        puts "Average alignment is #{alignment_average}%"
        puts "\n-----------------------------------\n\n"
      end
    end
    
    puts "\n====================================\n\n"
    puts "Completed report."
  end
end