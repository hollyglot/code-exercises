require_relative '../script_init'

main_title 'Set Required Technology with ER Tech Requirements'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Getting Products..."

    products = Product.all

    products.each do |product|
      er = product.product_review
      if er.present?
        fc = product.first_component
        puts product.title
        puts "Component:"
        puts fc.required_technology
        puts "ER:"
        puts er.technology_requirements
        puts "\n----------------------------------------\n"
        unless er.technology_requirements.blank?
          fc.set(:required_technology, er.technology_requirements)
        end
      end
    end

    puts "\n====================================\n\n"
    puts "Finished setting products."

  end
end