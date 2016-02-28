module Domain
	module Product
		module Reports
			module Comparison
				class Record

          extend ActiveSupport::Concern
          include ActiveModel::AttributeMethods
          include ActiveModel::Serializers::JSON
					extend  ActiveModel::Naming
          extend  ActiveModel::Translation
          include ActiveModel::Conversion

          attr_reader :attributes

					attr_accessor   :title,
                          :description,
                          :grade,
                          :subject,
                          :state_adopted,
                          :format,
                          :type,
                          :unit_price,
                          :student_groups_served,
                          :product_strengths,
                          :good_to_knows,
                          :alignment_report,
                          :whos_using,
                          :average_educator_ratings,
                          :technology_requirements,
                          :device_compatibility,
                          :publisher_questionnaire,
                          :comments

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