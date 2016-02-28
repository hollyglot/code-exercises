require 'csv'

module Domain
  module Product
    module Reports
      module Workflow
        module Records
          class CSVBuilder

            def self.!(sort_by, sort_direction, status)
              instance = new sort_by, sort_direction, status
              instance.!
            end

            def initialize(sort_by, sort_direction, status)
              @sort_by = sort_by
              @sort_direction = sort_direction
              @status = status
              @workflow = ::Domain::Product::Reports::Workflow::Index.new
            end

            def !
              records = get_records
              header = get_header
              csv = build records, header
              csv
            end

            def get_records
              filter = status_filter

              query = { filtered: { query: { match_all: {} }, filter: filter } }

              records = @workflow.search(
                query: query,
                sort: { "#{@sort_by}" => {order: "#{@sort_direction}"} },
                from: 0,
                size: count)

              records
            end

            def status_filter
              case @status
              when 'submitted'
                filter = { and: [{ term: { product_status_sort: "submitted" } }, { missing: { field: "alignment_report_status" }  }] }
              when 'editorial_review'
                filter = { term: { product_status_sort: "submitted" } }
              when 'assigned_to_first_sme'
                filter = { term: { alignment_report_status_sort: "assigned_to_first_sme" } }
              when 'assigned_to_second_sme'
                filter = {term: { alignment_report_status_sort: "assigned_to_second_sme" }}
              when 'ready_for_preview_period'
                filter = {term: { product_status_sort: "ready_for_preview_period" }}
              when 'preview_period_started'
                filter = {term: { product_status_sort: "preview_period_started" }}
              when 'preview_period_has_paused'
                filter = {term: { product_status_sort: "preview_period_has_paused" }}
              when 'preview_period_finished'
                filter = {term: { product_status_sort: "preview_period_finished" }}
              when 'published'
                filter = {term: { product_status_sort: "live_on_ll_com" }}
              when 'all'
                filter = {}
              end
            end

            def count
              filter = status_filter
              total_count = @workflow.count( query: { filtered: { query: { match_all: {} }, filter: filter } })
              total_count
            end

            def get_header
              ['Title',
              'Publisher',
              'Product Submitted',
              'Subject',
              'Grade',
              'Material Format',
              'Standard',
              'State Adopted',
              'Publisher Submitted Alignment Percentage',
              'Learning List Alignment Percentage',

              '1st SME',
              'Assigned to 1st SME',
              'Submitted by 1st SME',

              '2nd SME Name',
              'Assigned to 2nd SME',
              'Submitted by 2nd SME',

              '3rd SME',
              'Assigned to 3rd SME',
              'Submitted by 3rd SME',

              'Editorial Reviewer',
              'Assigned to ER',
              'Submitted by ER',

              'Publisher Preview Started',
              'Publisher Preview Finished',
              'Published',

              'Product Status']
            end

            def build(records, header)

              csv_string = CSV.generate do |csv|
                csv << header
                records.each do |record|
                  csv << [record.product_title,
                          record.publisher_name,
                          record.product_submitted_at,
                          record.product_subject,
                          record.product_grade,
                          record.product_material_format,
                          record.product_standard,
                          record.product_state_adopted,
                          record.publisher_alignment_percentage,
                          record.ll_alignment_percentage,

                          record.first_sme_name,
                          record.first_sme_assigned_at,
                          record.first_sme_submitted_at,

                          record.second_sme_name,
                          record.second_sme_assigned_at,
                          record.second_sme_submitted_at,

                          record.third_sme_name,
                          record.third_sme_assigned_at,
                          record.third_sme_submitted_at,

                          record.editorial_reviewer_name,
                          record.editorial_reviewer_assigned_at,
                          record.editorial_reviewer_submitted_at,

                          record.publisher_preview_started_at,
                          record.publisher_preview_finished_at,
                          record.published_at,
                          record.product_status]
                end
              end
              csv_string
            end
          end
        end
      end
    end
  end
end