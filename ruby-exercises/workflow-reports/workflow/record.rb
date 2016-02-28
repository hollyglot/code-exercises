require 'virtus'

module Domain
	module Product
		module Reports
			module Workflow
				class Record

          include Virtus.model

          include ActiveModel::AttributeMethods
          include ActiveModel::Serializers::JSON
					extend  ActiveModel::Naming
          extend  ActiveModel::Translation
          include ActiveModel::Conversion

          attr_reader :attributes

					attr_accessor :product_title,
                        :product_title_sort,
												:product_submitted_at,
                        :product_submitted_at_sort,
												:published_at,
                        :published_at_sort,
												:product_subject,
                        :product_subject_sort,
												:product_grade,
                        :product_grade_sort,
												:product_material_format,
                        :product_material_format_sort,
												:product_status,
                        :product_status_sort,
												:product_standard,
                        :product_standard_sort,
												:product_id,
                        :product_state_adopted

					attr_accessor :publisher_name,
                        :publisher_name_sort,
												:publisher_alignment_percentage

					attr_accessor :alignment_report_id,
												:alignment_report_status,
                        :alignment_report_status_sort

					attr_accessor :first_sme_name,
                        :first_sme_name_sort,
												:first_sme_assigned_at,
                        :first_sme_assigned_at_sort,
                        :first_sme_submitted_at,
												:first_sme_submitted_at_sort

					attr_accessor :second_sme_name,
                        :second_sme_name_sort,
												:second_sme_assigned_at,
                        :second_sme_assigned_at_sort,
                        :second_sme_submitted_at,
												:second_sme_submitted_at_sort

					attr_accessor :third_sme_name,
                        :third_sme_name_sort,
												:third_sme_assigned_at,
                        :third_sme_assigned_at_sort,
                        :third_sme_submitted_at,
												:third_sme_submitted_at_sort

					attr_accessor :editorial_reviewer_name,
                        :editorial_reviewer_name_sort,
												:editorial_reviewer_assigned_at,
                        :editorial_reviewer_assigned_at_sort,
                        :editorial_reviewer_submitted_at,
												:editorial_reviewer_submitted_at_sort,
												:editorial_review_status,
                        :editorial_review_status_sort

					attr_accessor :publisher_preview_started_at,
                        :publisher_preview_started_at_sort,
												:publisher_preview_finished_at_sort,
                        :publisher_preview_finished_at

					attr_accessor :ll_alignment_percentage

          def initialize(attributes = {})
            attributes.each do |name, value|
              send("#{name}=", value)
            end
          end

					def set_sme_info(ordinal, info)
						hsh = info.marshal_dump

						hsh.each do |attr_name, value|
							send :"#{ordinal}_sme_#{attr_name}=", value
						end
					end

          def to_hash
            instance_values
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