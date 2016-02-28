require_relative '../script_init'

main_title 'Update Order Payment Type'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "Getting orders with payment type stripe..."
    orders = Order.where(payment_type: 'stripe').to_a

    puts "\n-------------------------------------------------------\n\n"

    if orders
      puts "Changing payment type to credit card..."
      orders.each do |order|
        puts "Order:"
        puts order.id
        puts "\n-------------------------------------------------------\n\n"
        order.payment_type = 'credit_card'
        order.save
      end
    end

    puts "\n-------------------------------------------------------\n\n"
    puts "Finished setting orders payment type."
    puts "\n-------------------------------------------------------\n\n"
  end
end