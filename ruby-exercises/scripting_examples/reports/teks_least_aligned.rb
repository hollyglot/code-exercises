require_relative '../script_init'

main_title 'Find Least Aligned Standards'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Getting TEKS Alignment Templates...\n\n"

    standard = Standard.where(name: "TEKS").first
    teks_alignment_templates = AlignmentTemplate.where(standard_id: standard.id).asc(:subject, :grade)

    teks_alignment_templates.each do |at|
      puts "\n\nAlignment Template"
      puts at.title

      non_aligned_standards = []

      finalized_alignment_reports = at.alignment_reports.finalized

      number_of_reports = finalized_alignment_reports.count


      unless finalized_alignment_reports.empty?
        finalized_alignment_reports.each do |alignment_report|

          # Find root standard and checks for aligned and non-aligned standards
          ancestry_depth = alignment_report.alignment_template.standard.calculation_level
          alignment_report_table = ::Domain::AlignmentReport::Builders::DatatableBuilder.! alignment_report
          standards = []
          alignment_report_table.each do |row|

            # Ignore standards that are not addressed by publisher
            breakout = row.select { |element| element.pages.include? "Not addressed in publisher's correlation" if element.class == Breakout && element.pages }

            if !breakout || breakout.empty?
              breakout = row.select { |element| element.pages.include? "Not addressed in publisher&#39;s correlation" if element.class == Breakout && element.pages }
            end

            if !breakout || breakout.empty?
              row.each do |element|
                if element.class == Element && element.ancestry_depth == ancestry_depth
                  standards << element
                end
              end
            end
          end

          standards.flatten.uniq.each do |c|
            unless Domain::Element::Queries::AlignedByAlignmentReport.! c, alignment_report
              non_aligned_standards << "'#{(c.label || '').ljust(10)} #{c.content[0..50]}...'"
            end
          end
        end

        # make the hash default to 0 so that += will work correctly
        least_aligned = Hash.new(0)

        # iterate over the array, counting duplicate entries
        non_aligned_standards.each do |v|
          least_aligned[v] += 1
        end

        # sorts number of least aligned in descending order and returns array
        least_aligned_arry = least_aligned.sort_by { |k, v| v }.reverse

        least_aligned_arry.each do |aligned|
          puts "\n#{aligned[0]} is not aligned in #{aligned[1]}/#{number_of_reports} reports which is #{(aligned[1].to_f / number_of_reports.to_f * 100).round(1)}% not aligned."
        end
        puts "\n-----------------------------------\n\n"
      end
    end
    
    puts "\n====================================\n\n"
    puts "Completed report."
  end
end