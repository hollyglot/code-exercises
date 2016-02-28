require_relative '../sketches_init'

main_title 'Get Supplemental Products'

log = Telemetry::MongoidLog
log.clear!

log.output!

Benchmark.bmbm do |x|
  x.report do

    products = Product.all

    products.each do |product|
      if product.published?
        component = product.components.first
        if component.small_standards_subset
          puts product.id
          puts component.supplemental_replacement_text
        end
      end
    end

  end
end
