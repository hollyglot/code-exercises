module Domain
	module TermsAndCondition
		module Reports
			module PublishersAccepted
        class Builder

          def self.!(term)
            instance = build term
            instance.!
          end

          def self.build(term)
            accepted_terms = ::AcceptedTermsAndCondition.where(terms_and_condition_id: term.id).to_a

            publisher_ids = []
            accepted_terms.each do |term|
              publisher_ids << term.publisher_id
            end

            publisher_ids.uniq!
            publishers = ::Publisher.find(publisher_ids)

            publishers.sort! { |a, b| [a[:company_name]] <=> [b[:company_name]] }

            Builder.new publishers, accepted_terms
          end

          def initialize(publishers, accepted_terms)
            @publishers = publishers
            @accepted_terms = accepted_terms
          end

          def !
            publishers_accepted = build_records @publishers, @accepted_terms
            publishers_accepted
          end

          def build_records(publishers, accepted_terms)
            records = []

            publishers.each do |publisher|
              term = accepted_terms.select { |t| t.publisher_id == publisher.id}.first
              record = build_record publisher, term
              records << record
            end

            records
          end

          def build_record(publisher, accepted_term)
            accepted_publisher = Record.new
            accepted_publisher.name = publisher.company_name
            accepted_publisher.date_accepted = accepted_term.created_at.strftime('%m/%d/%Y %I:%M %P')
            accepted_publisher.publisher_id = publisher.id
            accepted_publisher
          end
        end
			end
		end
	end
end