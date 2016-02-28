require_relative '../script_init'

main_title 'Set Previous Terms of Service'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Update subscribers..."

    subscribers = Subscriber.where(:accepted_terms => true)
    @district_terms = TermsOfService.all_of(:current => true, :subscription_type => 'District/Campus').first
    @publisher_terms = TermsOfService.all_of(:current => true, :subscription_type => 'Publisher').first
    @individual_terms = TermsOfService.all_of(:current => true, :subscription_type => 'Individual').first

    puts "\n---------------------------------\n\n"
    puts "Subscribers:"
    puts subscribers.count

    subscribers.limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+1}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(20).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+21}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(40).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+41}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(60).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+61}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(80).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+81}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(100).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+101}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(120).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+121}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(140).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+141}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(160).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+161}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(180).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+181}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(200).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+201}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(220).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+221}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(240).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+241}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(260).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+261}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.inspect
      puts subscriber.accepted_terms_of_services.last.inspect
      puts subscriber.accepted_terms_of_services.last.terms_of_service.inspect
      subscriber.save
    end

    subscribers.skip(280).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+281}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end

    subscribers.skip(300).limit(20).each_with_index do |subscriber, index|
      puts "\n---------------------------------\n\n"
      puts "#{index+301}. #{subscriber.first_name} #{subscriber.last_name}"
      terms_accepted = subscriber.accepted_terms_of_services.build
      subscription_type = subscriber.type
      case subscription_type
      when 'individual_account'
        terms_accepted.terms_of_service_id = @individual_terms.id
      when 'publisher_account'
        terms_accepted.terms_of_service_id = @publisher_terms.id
      when 'organization_member'
        terms_accepted.terms_of_service_id = @district_terms.id
      when 'organizational_account'
        terms_accepted.terms_of_service_id = @district_terms.id
      end

      terms_accepted.created_at = subscriber.created_at
      terms_accepted.save
      puts subscriber.accepted_terms_of_services.last.inspect
      subscriber.save
    end


    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
 
  end
end