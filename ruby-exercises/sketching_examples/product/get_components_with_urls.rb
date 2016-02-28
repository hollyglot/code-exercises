require_relative '../sketches_init'

main_title 'Get Components with URLs'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do
    
    products = Product.where("components.notes" => /(http|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])?/i)
    
    products.each do |product|
      puts product.title
      puts product.id
      com = product.first_component
      puts "Compatible Devices"
      puts com.compatible_devices
      puts "Description"
      puts com.description
      puts "Notes"
      puts com.notes
      puts "Purchasing Url"
      puts com.purchasing_url
      puts "Required Technology"
      puts com.required_technology
    end
  end
end

log.output!
