require_relative '../sketches_init'

main_title 'Get Component field'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    products = Product.all

    products.each do |product|
      component = product.components.first
      if component.purchasing_url.nil?
        component.purchasing_url = 'http://www.google.com'
        product.save
      end
    end

  end
end

log.output!
