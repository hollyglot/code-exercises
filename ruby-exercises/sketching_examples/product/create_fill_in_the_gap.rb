require_relative '../sketches_init'

main_title 'Create Fill in the Gap'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    product = Product.find '5522efdec5ce7fc10600009b'
    alignment_report = product.alignment_reports.first

    Domain::Product::Builders::FillInTheGapByAlignmentReport.! product, alignment_report

    fitgs = FillInTheGap.where(:product_id => product.id)

    puts "New Fill In the Gaps:"
    fitgs.each do |fitg|
      puts fitg.inspect
    end

    puts "\nCount:"
    puts fitgs.count

  end
end