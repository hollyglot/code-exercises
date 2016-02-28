require_relative '../script_init'

main_title 'Set Order Index Fields'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    def migrate_orders(orders)
      orders.each do |order|
        order.set(:subscriber_name, order.subscriber.full_name)
        order.set(:tax_rate, order.subscription.tax_rate)
        order.set(:created_date, order.created_at.strftime("%Y/%m/%d"))
        puts "\n-------------------------------------------------------\n\n"
        puts "Migrated #{order.subscriber_name}"
        puts order.inspect
        puts "\n-------------------------------------------------------\n\n"

      end
    end

    orders = Order.all
    migrate_orders(orders)


    puts "\n-------------------------------------------------------\n\n"
    puts "Finished migrating orders."
    puts "\n-------------------------------------------------------\n\n"


  end
end