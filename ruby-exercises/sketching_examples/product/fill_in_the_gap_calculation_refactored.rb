require_relative '../sketches_init'

main_title 'Refactored Fill in the Gap Calculation'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    def create_fill_in_the_gap(aligned_standards, non_aligned_standards, na_standards, report)
      collection = []
      inverse_collection = []
      inverse_aligned_standards = []
      inverse_non_aligned_standards = []
      @standards.each do |element|
        if element.aligned?(report)
          inverse_aligned_standards << element.label
        elsif element.not_aligned?(report)
          inverse_non_aligned_standards << element.label
        end
      end

      standards_count = (aligned_standards.count + non_aligned_standards.count + na_standards.count)

      percent_multiplier = (100.0/standards_count).round(4)
      coverage_percent = ((aligned_standards.count.to_f/standards_count.to_f) * 100).round(3)
      puts "======================================"
      puts "\nNon-aligned"
      puts non_aligned_standards

      puts "\nInverse aligned:"
      puts inverse_aligned_standards

      intersect = non_aligned_standards & inverse_aligned_standards
      direct_coverage = (intersect.size*percent_multiplier).round(3)

      puts "\nDirect Coverage:"
      puts direct_coverage
      
      inverse_intersect = inverse_non_aligned_standards & aligned_standards
      inverse_coverage = (inverse_intersect.size*percent_multiplier).round(3)
      inverse_percent = ((inverse_aligned_standards.count.to_f/standards_count.to_f) * 100).round(3)

      collection << [[@product, direct_coverage.round(1), inverse_coverage, (coverage_percent+direct_coverage).round(1)], report.product, [aligned_standards, non_aligned_standards, inverse_aligned_standards], @alignment_report.id]
      inverse_collection << [[report.product, inverse_coverage.round(1), direct_coverage.round(1), (inverse_percent+inverse_coverage).round(1)], @product, [inverse_aligned_standards, inverse_non_aligned_standards, aligned_standards], report.id]


      # If coverage is zero, do not create Fill In The Gap
      collection.delete_if { |el| el[0][1].zero? }

      # Create Fill in the Gap
      collection.each do |element|
        puts "\n---------------------------------------"
        puts "Create fill in the gap...."
        puts "product_id:"
        puts element[0][0].id
        puts "coverage:"
        puts element[0][1]
        puts "inverse_coverage:"
        puts element[0][2]
        puts "total_coverage:"
        puts element[0][3]
        puts "compared_product_id:"
        puts element[1].id
        puts "aligned_standards:"
        puts element[2][0]
        puts "non_aligned_standards:"
        puts element[2][1]
        puts "inverse_aligned_standards:"
        puts element[2][2]
        puts "alignment_report:"
        puts element[3]
        puts "\n---------------------------------------"
      end


      inverse_collection.each do |element|
        puts "\n---------------------------------------"
        puts "Create inverse fill in the gap...."
        puts "product_id:"
        puts element[0][0].id
        puts "coverage:"
        puts element[0][1]
        puts "inverse_coverage:"
        puts element[0][2]
        puts "total_coverage:"
        puts element[0][3]
        puts "compared_product_id:"
        puts element[1].id
        puts "aligned_standards:"
        puts element[2][0]
        puts "non_aligned_standards:"
        puts element[2][1]
        puts "inverse_aligned_standards:"
        puts element[2][2]
        puts "alignment_report:"
        puts element[3]
        puts "---------------------------------------"
      end

    end

    def build_fill_in_the_gap
      aligned_standards = []
      non_aligned_standards = []
      na_standards = []

      # Finds parent standard and checks for aligned and non-aligned standards
      @standards.each do |element|
        if element.aligned?(@alignment_report)
          aligned_standards << element.label
        elsif element.not_aligned?(@alignment_report)
          non_aligned_standards << element.label
        elsif element.na?(@alignment_report)
          na_standards << element.label
        end
      end

      @reports.each do |report|
        create_fill_in_the_gap aligned_standards, non_aligned_standards, na_standards, report
      end
    end

    @product = Product.find "53972592f983f5f787000019"
    @alignment_report = @product.alignment_reports.first

    alignment_template = ::AlignmentTemplate.where(:id => @alignment_report.alignment_template_id).first
    @breakouts = @alignment_report.breakouts.to_a
    @reports = alignment_template.alignment_reports.finalized.ne(product_id: @product.id)

    ancestry_depth = @alignment_report.alignment_template.standard.calculation_level
    standards = alignment_template.elements.where(ancestry_depth: ancestry_depth).to_a
    standards.sort! { |a,b| a.label <=> b.label }
    @standards = standards.flatten.uniq

    build_fill_in_the_gap

  end
end