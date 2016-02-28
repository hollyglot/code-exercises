require_relative '../script_init'

main_title 'Migrate Profile to Subscriber'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    def set_expires_at(subscription=nil)
      if subscription && subscription.expire_at
        subscription.expire_at.strftime("%Y/%m/%d")
      end
    end

    def set_subscription_type(subscriber, subscription)
      if subscription && subscription.type
        puts subscriber.email
        puts subscription.inspect
        "#{subscriber.kind.titleize} - #{subscription.type.titleize}"
      elsif subscriber.kind
        "#{subscriber.kind.titleize}"
      end
    end

    def set_subscription_requested_or_activated_at(subscriber, subscription)
      if subscription
        if subscription.activated?
          subscription.started_at.strftime("%Y/%m/%d")
        else
          subscriber.created_at.strftime("%Y/%m/%d")
        end
      else
        subscriber.created_at.strftime("%Y/%m/%d")
      end
    end

    def set_status_in_business_terms(subscriber)
      Domain::Subscriber::Status::BusinessTerms.! subscriber
    end


    def migrate_subscribers(subscribers)
      subscribers.each do |subscriber|

        subscriber.set(:district, (Domain::District::Queries::NameBySubscriber.! subscriber))

        if subscriber.profile
          if subscriber.profile.first_name
            subscriber.set(:first_name, subscriber.profile.first_name)
          end

          if subscriber.profile.last_name
            subscriber.set(:last_name, subscriber.profile.last_name)
          end

          if subscriber.profile.contact_number
            subscriber.set(:contact_number, subscriber.profile.contact_number)
          end

          profile_photo = subscriber.profile.photo.to_s
          match = /profile_photo/.match(profile_photo)
          unless match
            SubscriberUpdatePhotoWorker.perform_async(subscriber.id)
          end

          if subscriber.profile.display_photo
            subscriber.set(:display_photo, subscriber.profile.display_photo)
          end
        end

        subscription = subscriber.current_subscription

        subscriber.set(:subscription_requested_or_activated_at, set_subscription_requested_or_activated_at(subscriber, subscription))
        subscriber.set(:subscription_expires_at, set_expires_at(subscription))
        subscriber.set(:subscription_type, set_subscription_type(subscriber, subscription))
        subscriber.set(:status_in_business_terms, set_status_in_business_terms(subscriber))

        puts "\n-------------------------------------------------------\n\n"
        puts "Migrated #{subscriber.email}"
        puts subscriber.inspect
        puts "\n-------------------------------------------------------\n\n"

      end
    end

    limit_num = 20

    skip_num = 20

    count = Subscriber.count

    times = (count / 20)

    remainder = (count % 20)

    if remainder
      times = times + 1
    end

    i = 0

    begin
      puts "\n-------------------------------------------------------\n\n"
      puts "Total Subscribers: #{count}"
      puts "Migrating batch ##{i + 1} of #{times}"
      puts "\n-------------------------------------------------------\n\n"

      subscribers = Subscriber.all.limit(limit_num).skip(skip_num * i)
      migrate_subscribers(subscribers)
      i +=1
    end until i > times

    puts "\n-------------------------------------------------------\n\n"
    puts "Finished migrating subscribers."
    puts "\n-------------------------------------------------------\n\n"


  end
end