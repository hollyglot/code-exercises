require 'ostruct'

module Domain
  module Product
    module Reports
      module AlignmentPercentage
        module ByStatus
          class RowBuilder

            def self.!(product, alignment_report=nil)
              instance = build product, alignment_report
              instance.!
            end

            def self.build(product, alignment_report=nil)
              row_builder(product, alignment_report)
            end

            def self.row_builder(product, alignment_report=nil)
              if product.alignment_reports.empty?
                RowBuilder.new product
              else
                RowBuilder.new product, alignment_report
              end
            end

            def initialize(product, alignment_report=nil)
              @product = product
              @alignment_report = alignment_report
            end

            def row
              @row ||= Row.new
            end

            def product
              @product
            end

            def alignment_report
              @alignment_report
            end

            def !
              product_info
              publisher_info
              alignment_report_info

              row
            end

            def product_info
              row.product_title         = product.title
              row.product_grade         = product.first_component.grade
              if product.first_component.state_verified_correlations.url.present?
                row.product_state_adopted = "Yes"
              else
                row.product_state_adopted = "No"
              end

              unless product.first_component.subject_id.nil?
                subject = ::Domain::Subject::Queries::Subject.! product.first_component.subject_id
                row.product_subject = subject.title
              end

              alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
              standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
              standard_name = standard.name if standard
              row.product_standard = standard_name

              status_changes = Domain::StatusChange::Queries::ByProduct.! product
              published  = get_status(status_changes, 'published')
              row.published_at = I18n.l(published.created_at, format: :american_date) if published

            end

            def publisher_info
              publisher = ::Domain::Publisher::Queries::Publisher.! product.publisher_id
              return unless publisher

              row.publisher_name = publisher.company_name
              row.publisher_alignment_percentage = "#{product.first_component.alignment_percentage}%" if product.first_component.alignment_percentage
            end

            def alignment_report_info
              return unless alignment_report

              row.ll_alignment_percentage = "#{alignment_report.coverage_percent}%" if alignment_report.coverage_percent
            end

            def get_status(status_changes, status)
              status_changes.find { |status_change| status_change[:status] == status }
            end
          end
        end
      end
    end
  end
end