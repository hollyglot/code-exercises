require_relative '../sketches_init'

main_title 'Get Supplemental Products'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    pub = Publisher.find '54654201a8e3e4050b000030'
    @current_terms = TermsAndCondition.where(current: true).first

    @accepted_terms = Domain::Publisher::Reports::AcceptedTerms::Builder.! pub

    @current_terms_are_accepted = Domain::AcceptedTermsAndCondition::Queries::ByPublisherAndCurrentTermsAndCondition.! pub, @current_terms
    puts @current_terms_are_accepted.inspect

  end
end
log.output!
log.clear!

Benchmark.bm do |x|
  x.report do

    pub = Publisher.find '54654201a8e3e4050b000030'
    @current_terms = TermsAndCondition.where(current: true).first

    @accepted_terms = Domain::Publisher::Reports::AcceptedTerms::Builder.! pub

    @current_terms_are_accepted = @accepted_terms.select { |t| t.term_id == @current_terms.id}.first
    puts @current_terms_are_accepted.inspect

  end
end

log.output!
