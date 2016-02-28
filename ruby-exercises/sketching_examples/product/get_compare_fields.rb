require_relative '../sketches_init'

require 'ostruct'
require 'nokogiri'

main_title 'Get Compare Fields'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    ids = ["52d0513cf983f53e1d001729", "51d487d7f983f5e2b50000e9", "5360ffcef983f57c49000117"]

    products = Product.find ids

    grades = ["K", "2", "5"]

    subjects = ["Math", "English", "Science"]

    user_prices = ["nil", "$255 per class", "$2000 per school"]

    user_comments = ["Love this product!", "nil", "Um, not sure"]

    comparison = Domain::Product::Reports::Comparison::Builder.! products, subjects, grades, user_prices, user_comments

    puts comparison[:header]

    comparison[:products].each do |product|
      puts "Product:"
      puts product.inspect
      puts "-----------------------------------------------------\n\n"
    end

  end
end