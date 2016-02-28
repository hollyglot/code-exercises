require_relative '../script_init'

main_title 'Update Subscribers Status'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do


    # ------------------------------------------------------------------------------

    puts "Set All Subscriber States with Expired Subscriptions..."
    puts "\n-------------------------------------------------------\n\n"

    subscriptions = Subscriptions.where(state: 'expired')

    puts "Expired Subscriptions"
    puts subscriptions.count

    subscriptions.each do |subscription|
      SubscriberUpdateStatusInBusinessTermsWorker.perform_async(subscription.id)
    end


    puts "\n-------------------------------------------------------\n\n"
    puts "Finished setting subscriber state to expired."
    puts "\n-------------------------------------------------------\n\n"

  end
end