module Domain
  module Product
    module Reports
      module Workflow
        module Records
          class Update

            def self.!(product)
              instance = new product
              instance.!
            end

            def initialize(product)
              @product = product
              @workflow_index = ::Domain::Product::Reports::Workflow::Index.new
            end

            def product
              @product
            end

            def !
              records = get_workflow_records
              update_records records
            end

            def get_workflow_records
              records = []
              records.push *build_records
              records
            end

            def build_records
              if product.alignment_reports.empty?
                record = []
                record << build_record(product)
                record
              else
                build_record_by_alignment_report
              end
            end

            def build_record_by_alignment_report
              records = []
              product.alignment_reports.each do |alignment_report|
                records << build_record(alignment_report)
              end
              records
            end

            def build_record(alignment_report=nil)
              ::Domain::Product::Reports::Workflow::Records::Builder.! product, alignment_report
            end

            def update_records(records)
              records.each do |record|
                if product.workflow_ids

                  # Set record fields
                  product_title = record.product_title if record.product_title
                  product_title_sort = record.product_title_sort if record.product_title_sort
                  product_submitted_at = record.product_submitted_at if record.product_submitted_at
                  product_submitted_at_sort = record.product_submitted_at_sort if record.product_submitted_at_sort
                  published_at = record.published_at if record.published_at
                  published_at_sort = record.published_at_sort if record.published_at_sort
                  product_subject = record.product_subject if record.product_subject
                  product_subject_sort = record.product_subject_sort if record.product_subject_sort
                  product_grade = record.product_grade if record.product_grade
                  product_grade_sort = record.product_grade_sort if record.product_grade_sort
                  product_material_format = record.product_material_format if record.product_material_format
                  product_material_format_sort = record.product_material_format_sort if record.product_material_format_sort
                  product_status = record.product_status if record.product_status
                  product_status_sort = record.product_status_sort if record.product_status_sort
                  product_standard = record.product_standard if record.product_standard
                  product_standard_sort = record.product_standard_sort if record.product_standard_sort

                  publisher_name = record.publisher_name if record.publisher_name
                  publisher_name_sort = record.publisher_name_sort if record.publisher_name_sort
                  publisher_alignment_percentage = record.publisher_alignment_percentage if record.publisher_alignment_percentage

                  alignment_report_id = record.alignment_report_id if record.alignment_report_id
                  alignment_report_status = record.alignment_report_status if record.alignment_report_status
                  alignment_report_status_sort = record.alignment_report_status_sort if record.alignment_report_status_sort

                  first_sme_name = record.first_sme_name if record.first_sme_name
                  first_sme_name_sort = record.first_sme_name_sort if record.first_sme_name_sort
                  first_sme_assigned_at = record.first_sme_assigned_at if record.first_sme_assigned_at
                  first_sme_assigned_at_sort = record.first_sme_assigned_at_sort if record.first_sme_assigned_at_sort
                  first_sme_submitted_at = record.first_sme_submitted_at if record.first_sme_submitted_at
                  first_sme_submitted_at_sort = record.first_sme_submitted_at_sort if record.first_sme_submitted_at_sort

                  second_sme_name = record.second_sme_name if record.second_sme_name
                  second_sme_name_sort = record.second_sme_name_sort if record.second_sme_name_sort
                  second_sme_assigned_at = record.second_sme_assigned_at if record.second_sme_assigned_at
                  second_sme_assigned_at_sort = record.second_sme_assigned_at_sort if record.second_sme_assigned_at_sort
                  second_sme_submitted_at = record.second_sme_submitted_at if record.second_sme_submitted_at
                  second_sme_submitted_at_sort = record.second_sme_submitted_at_sort if record.second_sme_submitted_at_sort

                  third_sme_name = record.third_sme_name if record.third_sme_name
                  third_sme_name_sort = record.third_sme_name_sort if record.third_sme_name_sort
                  third_sme_assigned_at = record.third_sme_assigned_at if record.third_sme_assigned_at
                  third_sme_assigned_at_sort = record.third_sme_assigned_at_sort if record.third_sme_assigned_at_sort
                  third_sme_submitted_at = record.third_sme_submitted_at if record.third_sme_submitted_at
                  third_sme_submitted_at_sort = record.third_sme_submitted_at_sort if record.third_sme_submitted_at_sort

                  editorial_reviewer_name = record.editorial_reviewer_name if record.editorial_reviewer_name
                  editorial_reviewer_name_sort = record.editorial_reviewer_name_sort if record.editorial_reviewer_name_sort
                  editorial_reviewer_assigned_at = record.editorial_reviewer_assigned_at if record.editorial_reviewer_assigned_at
                  editorial_reviewer_assigned_at_sort = record.editorial_reviewer_assigned_at_sort if record.editorial_reviewer_assigned_at_sort
                  editorial_reviewer_submitted_at = record.editorial_reviewer_submitted_at if record.editorial_reviewer_submitted_at
                  editorial_reviewer_submitted_at_sort = record.editorial_reviewer_submitted_at_sort if record.editorial_reviewer_submitted_at_sort
                  editorial_review_status = record.editorial_review_status if record.editorial_review_status
                  editorial_review_status_sort = record.editorial_review_status_sort if record.editorial_review_status_sort

                  publisher_preview_started_at = record.publisher_preview_started_at if record.publisher_preview_started_at
                  publisher_preview_started_at_sort = record.publisher_preview_started_at_sort if record.publisher_preview_started_at_sort
                  publisher_preview_finished_at = record.publisher_preview_finished_at if record.publisher_preview_finished_at
                  publisher_preview_finished_at_sort = record.publisher_preview_finished_at_sort if record.publisher_preview_finished_at_sort

                  ll_alignment_percentage = record.ll_alignment_percentage if record.ll_alignment_percentage

                  product.workflow_ids.each do |id|
                    workflow_record = @workflow_index.search(query: { ids: { values: [id]}})

                    if workflow_record.total > 0
                      if workflow_record.first.alignment_report_id && workflow_record.first.alignment_report_id == alignment_report_id.to_s

                        @workflow_index.update(id: id,
                              product_title:                        product_title,
                              product_title_sort:                   product_title_sort,
                              product_submitted_at:                 product_submitted_at,
                              product_submitted_at_sort:            product_submitted_at_sort,
                              published_at:                         published_at,
                              published_at_sort:                    published_at_sort,
                              product_subject:                      product_subject,
                              product_subject_sort:                 product_subject_sort,
                              product_grade:                        product_grade,
                              product_grade_sort:                   product_grade_sort,
                              product_material_format:              product_material_format,
                              product_material_format_sort:         product_material_format_sort,
                              product_status:                       product_status,
                              product_status_sort:                  product_status_sort,
                              product_standard:                     product_standard,
                              product_standard_sort:                product_standard_sort,

                              publisher_name:                       publisher_name,
                              publisher_name_sort:                  publisher_name_sort,
                              publisher_alignment_percentage:       publisher_alignment_percentage,

                              alignment_report_id:                  alignment_report_id,
                              alignment_report_status:              alignment_report_status,
                              alignment_report_status_sort:         alignment_report_status_sort,

                              first_sme_name:                       first_sme_name,
                              first_sme_name_sort:                  first_sme_name_sort,
                              first_sme_assigned_at:                first_sme_assigned_at,
                              first_sme_assigned_at_sort:           first_sme_assigned_at_sort,
                              first_sme_submitted_at:               first_sme_submitted_at,
                              first_sme_submitted_at_sort:          first_sme_submitted_at_sort,

                              second_sme_name:                      second_sme_name,
                              second_sme_name_sort:                 second_sme_name_sort,
                              second_sme_assigned_at:               second_sme_assigned_at,
                              second_sme_assigned_at_sort:          second_sme_assigned_at_sort,
                              second_sme_submitted_at:              second_sme_submitted_at,
                              second_sme_submitted_at_sort:         second_sme_submitted_at_sort,

                              third_sme_name:                       third_sme_name,
                              third_sme_name_sort:                  third_sme_name_sort,
                              third_sme_assigned_at:                third_sme_assigned_at,
                              third_sme_assigned_at_sort:           third_sme_assigned_at_sort,
                              third_sme_submitted_at:               third_sme_submitted_at,
                              third_sme_submitted_at_sort:          third_sme_submitted_at_sort,

                              editorial_reviewer_name:              editorial_reviewer_name,
                              editorial_reviewer_name_sort:         editorial_reviewer_name_sort,
                              editorial_reviewer_assigned_at:       editorial_reviewer_assigned_at,
                              editorial_reviewer_assigned_at_sort:  editorial_reviewer_assigned_at_sort,
                              editorial_reviewer_submitted_at:      editorial_reviewer_submitted_at,
                              editorial_reviewer_submitted_at_sort: editorial_reviewer_submitted_at_sort,
                              editorial_review_status:              editorial_review_status,
                              editorial_review_status_sort:         editorial_review_status_sort,

                              publisher_preview_started_at:         publisher_preview_started_at,
                              publisher_preview_started_at_sort:    publisher_preview_started_at_sort,
                              publisher_preview_finished_at:        publisher_preview_finished_at,
                              publisher_preview_finished_at_sort:   publisher_preview_finished_at_sort,

                              ll_alignment_percentage:              ll_alignment_percentage)
                      end
                    else
                      @workflow_index.update(id: id,
                            product_title:                        product_title,
                            product_title_sort:                   product_title_sort,
                            product_submitted_at:                 product_submitted_at,
                            product_submitted_at_sort:            product_submitted_at_sort,
                            published_at:                         published_at,
                            published_at_sort:                    published_at_sort,
                            product_subject:                      product_subject,
                            product_subject_sort:                 product_subject_sort,
                            product_grade:                        product_grade,
                            product_grade_sort:                   product_grade_sort,
                            product_material_format:              product_material_format,
                            product_material_format_sort:         product_material_format_sort,
                            product_status:                       product_status,
                            product_status_sort:                  product_status_sort,
                            product_standard:                     product_standard,
                            product_standard_sort:                product_standard_sort,

                            publisher_name:                       publisher_name,
                            publisher_name_sort:                  publisher_name_sort,
                            publisher_alignment_percentage:       publisher_alignment_percentage,

                            alignment_report_id:                  alignment_report_id,
                            alignment_report_status:              alignment_report_status,
                            alignment_report_status_sort:         alignment_report_status_sort,

                            first_sme_name:                       first_sme_name,
                            first_sme_name_sort:                  first_sme_name_sort,
                            first_sme_assigned_at:                first_sme_assigned_at,
                            first_sme_assigned_at_sort:           first_sme_assigned_at_sort,
                            first_sme_submitted_at:               first_sme_submitted_at,
                            first_sme_submitted_at_sort:          first_sme_submitted_at_sort,

                            second_sme_name:                      second_sme_name,
                            second_sme_name_sort:                 second_sme_name_sort,
                            second_sme_assigned_at:               second_sme_assigned_at,
                            second_sme_assigned_at_sort:          second_sme_assigned_at_sort,
                            second_sme_submitted_at:              second_sme_submitted_at,
                            second_sme_submitted_at_sort:         second_sme_submitted_at_sort,

                            third_sme_name:                       third_sme_name,
                            third_sme_name_sort:                  third_sme_name_sort,
                            third_sme_assigned_at:                third_sme_assigned_at,
                            third_sme_assigned_at_sort:           third_sme_assigned_at_sort,
                            third_sme_submitted_at:               third_sme_submitted_at,
                            third_sme_submitted_at_sort:          third_sme_submitted_at_sort,

                            editorial_reviewer_name:              editorial_reviewer_name,
                            editorial_reviewer_name_sort:         editorial_reviewer_name_sort,
                            editorial_reviewer_assigned_at:       editorial_reviewer_assigned_at,
                            editorial_reviewer_assigned_at_sort:  editorial_reviewer_assigned_at_sort,
                            editorial_reviewer_submitted_at:      editorial_reviewer_submitted_at,
                            editorial_reviewer_submitted_at_sort: editorial_reviewer_submitted_at_sort,
                            editorial_review_status:              editorial_review_status,
                            editorial_review_status_sort:         editorial_review_status_sort,

                            publisher_preview_started_at:         publisher_preview_started_at,
                            publisher_preview_started_at_sort:    publisher_preview_started_at_sort,
                            publisher_preview_finished_at:        publisher_preview_finished_at,
                            publisher_preview_finished_at_sort:   publisher_preview_finished_at_sort,

                            ll_alignment_percentage:              ll_alignment_percentage)
                    end
                  end
                else
                  response = @workflow_index.save(record)
                  if response["created"]
                    product.push(:workflow_ids, response["_id"])
                  end
                end

              end
            end
          end

        end
      end
    end
  end
end