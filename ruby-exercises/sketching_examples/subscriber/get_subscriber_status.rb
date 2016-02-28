require_relative '../sketches_init'

main_title 'Find all subscriber status and registration steps'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n-----------------------------------------\n\n"
    puts 'Getting subscriber statuses...'

    # ["subscription_complete", "checkout", "created_profile", "new", "registered", "subscription_not_complete", "payment_check_complete", "subscription_pending_payment_check", "subscription_rate_sought", "checked_enrollment"]

    # Steps...
    # 10
    # ["districts", "checkout", "registration_completed", "payment_confirmation", "payment_by_check", "payment_details", "enrollment_support", "owner_choose_district", "enrollment_verification", "enrollment_ask"]

    puts "\n---------------------------------------\n\n"

    statuses = []
    steps = []

    subscribers = Subscriber.all.to_a

    subscribers.each do |subscriber|
      statuses << subscriber.status
      steps << subscriber.registration_step
    end

    statuses.uniq!
    steps.uniq!

    puts 'Statuses...'
    puts statuses.count
    puts statuses.inspect
    puts "\n---------------------------------------\n\n"

    puts 'Steps...'
    puts steps.count
    puts steps.inspect
    puts "\n---------------------------------------\n\n"

    puts 'Done!'

  end
end