module Domain
	module TermsAndCondition
		module Reports
			module PublishersAccepted
				class Record

          extend ActiveSupport::Concern
          include ActiveModel::AttributeMethods
          include ActiveModel::Serializers::JSON
					extend  ActiveModel::Naming
          extend  ActiveModel::Translation
          include ActiveModel::Conversion

          attr_reader :attributes

					attr_accessor   :name,
                          :date_accepted,
                          :publisher_id

          def initialize(attributes = {})
            attributes.each do |name, value|
              send("#{name}=", value)
            end
          end

          def method_missing(method_name, *arguments, &block)
            attributes.respond_to?(method_name) ? attributes.__send__(method_name, *arguments, &block) : super
          end

          def persisted?
            false
          end
				end
			end
		end
	end
end