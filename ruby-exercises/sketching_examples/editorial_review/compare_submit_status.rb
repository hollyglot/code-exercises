require_relative '../sketches_init'

main_title 'Find Due To Statement'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n-----------------------------------------\n\n"
    puts 'Find editorial reviews missing submitted status changes...'

    ers = ProductReview.where(state: 'submitted').to_a

    published = []
    puts ers.count
    ers.each do |er|
      published_status = StatusChange.any_of(:status_changeable_id => er.id, :status => 'submit_product_review').first
      published << 'yes' if published_status
      unless published_status
        statuses = er.status_changes
        unless statuses.empty?
          puts statuses.inspect
        end
      end
    end
    puts published.length
    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end