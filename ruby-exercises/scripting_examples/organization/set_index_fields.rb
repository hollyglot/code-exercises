require_relative '../script_init'

main_title 'Set Organization Index Fields'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    def set_status_in_business_terms(organization)
      Domain::Organization::Status::BusinessTerms.! organization
    end


    def migrate_organizations(organizations)
      organizations.each do |organization|
        organization.set(:status_in_business_terms, set_status_in_business_terms(organization))
        organization.set(:owner_name, organization.owner.full_name)
        organization.set(:member_count, organization.members.count)
        organization.set(:subscription_activated_at, organization.subscription.started_at.strftime("%Y/%m/%d")) if organization.subscription.started_at

        puts "\n-------------------------------------------------------\n\n"
        puts "Migrated #{organization.name}"
        puts organization.inspect
        puts "\n-------------------------------------------------------\n\n"

      end
    end

    organizations = Organization.all
    migrate_organizations(organizations)


    puts "\n-------------------------------------------------------\n\n"
    puts "Finished migrating organizations."
    puts "\n-------------------------------------------------------\n\n"


  end
end