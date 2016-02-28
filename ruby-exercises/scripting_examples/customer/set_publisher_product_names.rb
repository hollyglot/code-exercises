require_relative '../script_init'

main_title 'Set Product and Publisher Names'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Update customers..."


    puts "\n---------------------------------\n\n"
    puts "Customers:"
    customers = Customer.all
    puts customers.count

    customers.limit(100).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(100).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+101}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(200).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+201}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(300).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+301}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(400).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+401}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(500).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+501}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(600).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+601}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(700).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+701}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(800).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+801}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(900).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+901}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(1000).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1001}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(1100).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1101}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(1200).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1201}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(1300).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1301}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(1400).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1401}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(1500).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1501}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(1600).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1601}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(1700).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1701}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(1800).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1801}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(1900).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1901}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(2000).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+2001}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(2100).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+2101}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(2200).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+2201}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(2300).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+2301}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(2400).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+2401}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(2500).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+2501}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(2600).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+2601}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(2700).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+2701}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(2800).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+2801}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(2900).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+2901}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(3000).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+3001}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(3100).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+3101}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(3100).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+3101}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(3200).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+3201}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(3300).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+3301}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(3400).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+3401}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(3500).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+3501}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    customers.limit(100).skip(3600).each_with_index do |customer, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+3601}. #{customer.first_name} #{customer.last_name}"

      if customer.customerable
        customer.publisher_name = customer.customerable.publisher_name
        customer.product_name = customer.customerable.title
        puts customer.inspect
        customer.save
      end      
    end

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
 
  end
end