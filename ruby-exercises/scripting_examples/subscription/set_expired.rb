require_relative '../script_init'

main_title 'Expire Subscriptions'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do


    # ------------------------------------------------------------------------------

    puts "Set Expired Subscriptions..."
    puts "\n-------------------------------------------------------\n\n"

    expired_subscriptions = Subscription.where(:expire_at.lte => Date.current)
    
    sub_count = expired_subscriptions.count

    puts "Expired Subscriptions:"
    puts sub_count

    puts "Expiring:"
    expired_subscriptions.each_with_index do |subscription, index|
      SubscriberUpdateStatusInBusinessTermsWorker.perform_async(subscription.id)
    end
    puts "Finished."


    puts "\n-------------------------------------------------------\n\n"
    puts "Finished expiring subscriptions."
    puts "\n-------------------------------------------------------\n\n"

  end
end