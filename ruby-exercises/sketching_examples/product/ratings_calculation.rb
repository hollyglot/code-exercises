require_relative '../sketches_init'

main_title 'Calculate Ratings'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bmbm do |x|
  x.report do

    def update_rating(product)

      rates = []
      puts product.ratings.where(rater_type: 'Subscriber').to_a

      puts "\n---------------------------------------------\n"
      # # Old method
      # product.ratings.where(rater_type: 'Subscriber').each{ |rating| rates << rating.results.values if rating.present? }
      # rates.transpose.each_with_index { |values,i| rates[i] = (values.inject(0.0){ |sum, el| sum + el.to_i }.to_f / values.size).round(2) }
      # puts rates.inspect
      # rates
      
      # New method
      all_rates = []
      rates_a = []
      rates_b = []
      rates_c = []
      rates_d = []
      rates_e = []
      rates_f = []
      rates_g = []
      product.ratings.where(rater_type: 'Subscriber').each do |rating| 
        rates_a << rating.results.values[0] unless rating.results.values[0] == "0"
        rates_b << rating.results.values[1] unless rating.results.values[1] == "0"
        rates_c << rating.results.values[2] unless rating.results.values[2] == "0"
        rates_d << rating.results.values[3] unless rating.results.values[3] == "0"
        rates_e << rating.results.values[4] unless rating.results.values[4] == "0"
        rates_f << rating.results.values[5] unless rating.results.values[5] == "0"
        rates_g << rating.results.values[6] unless rating.results.values[6] == "0"
      end
      all_rates << rates_a << rates_b << rates_c << rates_d << rates_e << rates_f << rates_g
      all_rates.each do |array|
        if array.empty?
          array << nil
        end
      end
      puts all_rates.inspect
      all_rates.each_with_index { |values,i| all_rates[i] = (values.inject(0.0){ |sum, el| sum + el.to_i }.to_f / values.size).round(2) }

      puts all_rates.inspect
    end

    product = Product.find '51bba377f983f5535a0003a6'

    update_rating(product)

  end
end

log.output!
