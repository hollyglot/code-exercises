require_relative '../sketches_init'

main_title 'Change state of subscription to expired if it has expired'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n-----------------------------------------\n\n"
    puts 'Getting subscriptions ...'

    Subscription.each do |subscription|
      if subscription.expire_at.present?
        if Date.current > subscription.expire_at
          if subscription.type == "trial"
            subscription.activate!
          elsif
            if subscription.subscriptionable_type == 'Organization'
              owner = subscription.subscriptionable.owner
              owner.set(:status_in_business_terms, 'Subscription Expired')

              subscribers = subscription.subscriptionable.members
              unless subscribers.empty?
                subscribers.each do |subscriber|
                  subscriber.set(:status_in_business_terms, 'Subscription Expired')
                end
              end

            else
              subscriber = subscription.subscriptionable
              subscriber.set(:status_in_business_terms, 'Subscription Expired')
            end
          end
          puts subscription.inspect
        end
      end
    end
    puts "Done!"
  end
end