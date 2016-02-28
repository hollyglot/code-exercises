require_relative '../script_init'

main_title 'Set Previous Terms and Conditions'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Update publishers..."

    publishers = Publisher.all_of(:terms_accepted => true, :created_at.gt => 5.days)
    terms = TermsAndCondition.where(:version => "2013.09.01").first
    puts "\n---------------------------------\n\n"
    puts "Past Terms"
    puts terms.id

    puts "\n---------------------------------\n\n"
    puts "Publishers:"
    puts publishers.count

    publishers.limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(10).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+11}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(20).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+21}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(30).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+31}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(40).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+41}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(50).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+51}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(60).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+61}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(70).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+71}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(40).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+41}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(50).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+51}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(60).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+61}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(70).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+71}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(80).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+81}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(90).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+91}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(100).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+101}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end

    publishers.skip(110).limit(10).each_with_index do |publisher, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+111}. #{publisher.company_name}"
      accepted_terms = publisher.accepted_terms_and_conditions.build
      accepted_terms.terms_and_condition_id = terms.id
      accepted_terms.created_at = publisher.created_at
      accepted_terms.save
      puts publisher.accepted_terms_and_conditions.last.inspect
      publisher.save
    end


    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
 
  end
end