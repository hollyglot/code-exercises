require_relative '../sketches_init'

main_title 'Old Fill in the Gap Calculation'

log = Telemetry::MongoidLog
log.clear!

def standard_aligned?(alignment_report, element)
  !Breakout.where(
    :element_id.in        => element.subtree_ids,
    :alignment_report_id  => alignment_report.id,
    :addressed.in         => [:unsatisfied, :not_applicable]
  ).any?
end

def standard_not_aligned?(alignment_report, element)
  Breakout.where(
    :element_id.in        => element.subtree_ids,
    :alignment_report_id  => alignment_report.id,
    :addressed            => :unsatisfied
  ).any?
end

Benchmark.bmbm do |x|
  x.report do

    product = Product.find '524adb89f983f5868e000324'
    alignment_report = product.alignment_reports.first

    reports     = []
    collection  = []
    inverse_collection = []
    aligned_standards = []
    non_aligned_standards = []

    # Finds parent standard and checks for aligned and non-aligned standards
    standards = alignment_report.root_elements
    standards.sort! { |a,b| a.label <=> b.label }
    standards.flatten.uniq.map! do |c|
      if standard_aligned?(alignment_report, c)
        aligned_standards << c.label
      elsif standard_not_aligned?(alignment_report, c)
        non_aligned_standards << c.label
      end
    end

    percent_multiplier = (100.0/standards.count).round(4)
    coverage_percent = ((aligned_standards.count.to_f/standards.count.to_f) * 100).round(3)

    puts 'Product aligned standards:'
    puts aligned_standards.inspect
    puts "\nProduct non-aligned standards:"
    puts non_aligned_standards.inspect

    compare_product = Product.find '5522efa2c5ce7fcd4c000092'

    report = compare_product.alignment_reports.first

    unless report.nil?
      # Finds parent standard and checks for aligned and non-aligned standards
      inverse_aligned_standards = []
      inverse_non_aligned_standards = []
      inverse_standards = standards
      inverse_standards.flatten.uniq.map! do |c|
        if standard_aligned?(report, c)
          inverse_aligned_standards << c.label
        elsif standard_not_aligned?(report, c)
          inverse_non_aligned_standards << c.label
        end
      end
    end

    puts 'Product 2 aligned standards:'
    puts inverse_aligned_standards.inspect
    puts "\nProduct 2 non-aligned standards:"
    puts inverse_non_aligned_standards.inspect

    intersect = non_aligned_standards & inverse_aligned_standards

    puts "Covered standards"
    puts intersect.inspect

    direct_coverage = (intersect.size*percent_multiplier).round(3)

    puts "Coverage"
    puts direct_coverage


    inverse_intersect = inverse_non_aligned_standards & aligned_standards
    inverse_coverage = (inverse_intersect.size*percent_multiplier).round(3)
    inverse_percent = ((inverse_aligned_standards.count.to_f/inverse_standards.count.to_f) * 100).round(3)

    collection << [[product, direct_coverage.round(1), (coverage_percent+direct_coverage).round(1)], report.product, [aligned_standards, non_aligned_standards, inverse_aligned_standards], alignment_report.id]
    inverse_collection << [[report.product, inverse_coverage.round(1), (inverse_percent+inverse_coverage).round(1)], product, [inverse_aligned_standards, inverse_non_aligned_standards, aligned_standards], report.id]

    dc = direct_coverage.round(1)

    puts "\nZero coverage?"
    puts dc.zero?



    puts "\ncollection"
    puts collection.inspect

    # If coverage is zero, do not create Fill In The Gap
    collection.delete_if { |el| el[0][1].zero? }


    puts "\nFill in the Gap Product"
    collection.each do |element|
      product_id = element[1].id
      p = Product.find product_id
      puts p.title
    end


    # If coverage is zero, do not create Fill In The Gap for compared product
    inverse_collection.delete_if { |el| el[0][1].zero? }

    # Creates Fill in the Gap for compared product. Required for Compared Products that have finalized alignment reports
    # or fill in the gap will not display on the Compared Product details.

    puts "\nInverse Fill in the Gap Product"
    inverse_collection.each do |element|
      product_id = element[1].id
      p = Product.find product_id
      puts p.title
    end

  end
end

log.output!