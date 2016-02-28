require_relative '../script_init'

main_title 'Set Products Published date'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Getting Products..."

    products = Product.all

    count = products.count
    products.each_with_index do |product, index|
      puts "Processing product ##{index+1} of #{count}"
      status_change = StatusChange.where(:status_changeable_id => product.id, :status => "published").desc(:created_at).first
      product.set(:published_at, status_change.created_at) if status_change
    end

    puts "\n====================================\n\n"
    puts "Finished setting products."

  end
end