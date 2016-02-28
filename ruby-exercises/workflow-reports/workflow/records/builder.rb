require 'ostruct'

module Domain
  module Product
    module Reports
      module Workflow
        module Records
          class Builder

            def self.!(product, alignment_report=nil)
              instance = build product, alignment_report
              instance.!
            end

            def self.build(product, alignment_report=nil)
              if product.alignment_reports.empty?
                Builder.new product
              else
                Builder.new product, alignment_report
              end
            end

            def initialize(product, alignment_report=nil)
              @product = product
              @alignment_report = alignment_report
            end

            def record
              @record ||= ::Domain::Product::Reports::Workflow::Record.new
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
              editorial_reviewer_info
              product_review_info

              record
            end

            def product_info
              record.product_id                  = product.id
              record.product_title               = product.title
              record.product_title_sort          = product.title.downcase.to_snake_case
              record.product_grade               = product.first_component.grade
              record.product_grade_sort          = product.first_component.grade.downcase.to_snake_case
              product_state                      = ::Domain::Product::Status::BusinessTerms.! product.state
              record.product_status_sort         = product_state.downcase.to_snake_case
              record.product_status              = product_state
              if product.state_verified_correlations.present?
                record.product_state_adopted = "Yes"
              else
                record.product_state_adopted = "No"
              end

              unless product.components.first.material_format.nil?
                record.product_material_format_sort  = product.components.first.material_format.map { |mf| mf.to_snake_case }
                record.product_material_format       = product.components.first.material_format.map(&:inspect).join(', ').gsub('"', '')
              end

              unless product.first_component.subject_id.nil?
                subject = ::Domain::Subject::Queries::Subject.! product.first_component.subject_id
                record.product_subject        = subject.title
                record.product_subject_sort   = subject.title.downcase.to_snake_case
              end

              alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
              standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
              standard_name = standard.name if standard

              record.product_standard        = standard_name
              record.product_standard_sort   = standard_name.downcase.to_snake_case if standard_name

              status_changes = ::Domain::StatusChange::Queries::ByProduct.! product

              editorial_reviewer_assigned                 = get_status(status_changes, 'assign_er')
              record.editorial_reviewer_assigned_at_sort  = editorial_reviewer_assigned.created_at.to_time.iso8601 if editorial_reviewer_assigned
              record.editorial_reviewer_assigned_at       = I18n.l(editorial_reviewer_assigned.created_at, format: :american_date) if editorial_reviewer_assigned


              publisher_preview_started                  = get_status(status_changes, 'preview_period')
              record.publisher_preview_started_at_sort   = publisher_preview_started.created_at.to_time.iso8601 if publisher_preview_started
              record.publisher_preview_started_at        = I18n.l(publisher_preview_started.created_at, format: :american_date) if publisher_preview_started

              publisher_preview_finished                 = get_status(status_changes, 'preview_finished')
              record.publisher_preview_finished_at_sort   = publisher_preview_finished.created_at.to_time.iso8601 if publisher_preview_finished
              record.publisher_preview_finished_at       = I18n.l(publisher_preview_finished.created_at, format: :american_date) if publisher_preview_finished

              submitted  = get_status(status_changes, 'submitted')
              if submitted
                record.product_submitted_at_sort    = submitted.created_at.to_time.iso8601
                record.product_submitted_at         = I18n.l(submitted.created_at, format: :american_date)
              else
                record.product_submitted_at_sort   = product.created_at.to_time.iso8601
                record.product_submitted_at        = I18n.l(product.created_at, format: :american_date)
              end

              published                 = get_status(status_changes, 'published')
              record.published_at_sort  = published.created_at.to_time.iso8601 if published
              record.published_at       = I18n.l(published.created_at, format: :american_date) if published
            end

            def publisher_info
              publisher = ::Domain::Publisher::Queries::Publisher.! product.publisher_id
              return unless publisher

              record.publisher_name                   = publisher.company_name
              record.publisher_name_sort              = publisher.company_name.downcase.to_snake_case
              record.publisher_alignment_percentage   = "#{product.first_component.alignment_percentage}%" if product.first_component.alignment_percentage
            end

            def alignment_report_info
              return unless alignment_report
              smes_info

              record.alignment_report_id           = alignment_report.id
              record.alignment_report_status_sort  = alignment_report.state.downcase.to_snake_case
              record.alignment_report_status       = alignment_report.state.titleize
              record.ll_alignment_percentage       = "#{alignment_report.coverage_percent}%" if alignment_report.coverage_percent
            end

            def smes_info
              status_changes = ::Domain::StatusChange::Queries::ByAlignmentReport.! alignment_report

              [:first, :second, :third].each do |ordinal|
                sme_id = alignment_report.send :"#{ordinal}_sme_id"
                sme_info(status_changes, ordinal, sme_id)
              end
            end

            def sme_info(status_changes, ordinal, sme_id=nil)
              sme = ::Domain::SME::Queries::SME.! sme_id
              return unless sme

              sme_info = OpenStruct.new

              sme_info.name      = sme.name
              sme_info.name_sort = sme.name.downcase.to_snake_case

              submitted = get_status(status_changes, "submitted_by_#{ordinal}_sme")
              sme_info.submitted_at_sort  = submitted.created_at.to_time.iso8601 if submitted
              sme_info.submitted_at       = I18n.l(submitted.created_at, format: :american_date) if submitted

              assigned = get_status(status_changes, "assigned_to_#{ordinal}_sme")
              sme_info.assigned_at_sort   = assigned.created_at.to_time.iso8601 if assigned
              sme_info.assigned_at        = I18n.l(assigned.created_at, format: :american_date) if assigned

              record.set_sme_info(ordinal, sme_info)
            end

            def editorial_reviewer_info
              editorial_reviewer = ::Domain::EditorialReviewer::Queries::EditorialReviewer.! product.editorial_reviewer_id
              return unless editorial_reviewer

              record.editorial_reviewer_name       = editorial_reviewer.name
              record.editorial_reviewer_name_sort  = editorial_reviewer.name.downcase.to_snake_case
            end

            def product_review_info
              product_review = ::Domain::ProductReview::Queries::ByProduct.! product
              return unless product_review

              record.editorial_review_status        = product_review.state.titleize
              record.editorial_review_status_sort   = product_review.state.downcase.to_snake_case

              status_changes = ::Domain::StatusChange::Queries::ByProductReview.! product_review
              return unless status_changes

              submitted = get_status(status_changes, 'submit_product_review"')
              record.editorial_reviewer_submitted_at_sort   = submitted.created_at.to_time.iso8601 if submitted
              record.editorial_reviewer_submitted_at       = I18n.l(submitted.created_at, format: :american_date) if submitted
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