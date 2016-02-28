require_relative '../sketches_init'

main_title 'Get a list of published product images'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    published_products = Product.where(state: "published").all

    published_products.each do |product|
      image = product.image_identifier
      puts image
    end

  end
end