require_relative '../script_init'

main_title 'Set Authorized Member Organization'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do


    # ------------------------------------------------------------------------------

    def get_organization(id)
      Organization.where(owner_id: id).first
    end

    def get_owner(domain)
      Subscriber.all_of(:email => /#{domain}/i, :type => 'organizational_account').first
    end

    puts "Find authorized members missing organizations..."
    puts "\n-------------------------------------------------------\n\n"

    subscribers = Subscriber.all_of(:organization_id => nil, :type => 'organization_member').to_a

    puts "Count:"
    puts subscribers.count
    puts "\n-------------------------------------------------------\n\n"

    subscribers.each do |subscriber|
      puts "Setting organization for #{subscriber.email}..."
      puts "\n-------------------------------------------------------\n\n"
      domain = subscriber.email.gsub(/.+@([^.]+).+/, '\1')
      owner = get_owner(domain)
      organization = get_organization(owner.id)
      subscriber.set(:organization_id, organization.id)
    end


    puts "\n-------------------------------------------------------\n\n"
    puts "Finished setting authorized members organizations."
    puts "\n-------------------------------------------------------\n\n"

  end
end