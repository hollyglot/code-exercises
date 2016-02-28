require_relative '../sketches_init'

main_title 'Get Publishers Who Have Accepted Terms'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    @current_terms = TermsAndCondition.where(version: "2013.09.01").first

    terms = AcceptedTermsAndCondition.where(terms_and_condition_id: @current_terms.id).limit(20)

    terms.each do |term|
      publisher = Publisher.where(id: term.publisher_id).first
      puts "Publisher: #{publisher.company_name}, Accepted: #{term.created_at.strftime('%m/%d/%Y %I:%M %P')}"
    end

  end
end

log.output!

log.clear!

Benchmark.bm do |x|
  x.report do

    current_terms = TermsAndCondition.where(version: "2013.09.01").first

    records = Domain::TermsAndCondition::Reports::PublishersAccepted::Builder.! current_terms

    records.each do |record|
      puts "Publisher: #{record.name}, Accepted: #{record.date_accepted}"
    end

  end
end

log.output!
