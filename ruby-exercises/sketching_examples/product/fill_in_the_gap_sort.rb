require_relative '../sketches_init'

main_title 'Fill in the Gap Sorting'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do
    puts "\n----------------------------------"
    puts "\n Old sort method\n"
    product = Product.find '53c6fd09f983f5598c000296'
    products_with_coverage = []
    product.fill_in_the_gaps.each { |el| products_with_coverage << [el.compared_product, el.coverage, el.total_coverage] }

    products_with_coverage.delete_if{ |el| (el[2].nil? || el[2] < 100) || !el[0].published? }.sort { |x,y| y[1] <=> x[1] }.uniq

    products_with_coverage.each do |ary|
      fitg_product = ary[0]
      puts "\n Product:"
      puts fitg_product.title
    end

  end
end

Benchmark.bm do |x|
  x.report do
    puts "\n----------------------------------"
    puts "\n New sort method\n"
    product = Product.find '53c6fd09f983f5598c000296'
    products_with_coverage = []
    product.fill_in_the_gaps.each            { |el| products_with_coverage << [el.compared_product, el.coverage, el.total_coverage] }

    products_with_coverage.delete_if{ |el| (el[2].nil? || el[2] < 100) || !el[0].published? }
    products_with_coverage = products_with_coverage.sort_by { |ary| [ary[0].alignment_reports[0].title, ary[1], ary[0].title] }.uniq

    products_with_coverage.each do |ary|
      puts "\n----------------------------------"
      fitg_product = ary[0]
      puts "\nProduct:"
      puts fitg_product.title
      puts "Alignment Report:"
      puts fitg_product.alignment_reports[0].title
      puts "Coverage:"
      puts ary[1]
    end

  end
end

