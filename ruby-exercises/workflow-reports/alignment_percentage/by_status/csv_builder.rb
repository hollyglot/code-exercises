require 'csv'

module Domain
  module Product
    module Reports
      module AlignmentPercentage
        module ByStatus
          class CSVBuilder

            def self.!(status)
              instance = new status
              instance.!
            end

            def initialize(status)
              @status = status
            end

            def !
              table = ::Domain::Product::Reports::AlignmentPercentage::ByStatus::TableBuilder.! @status
              header = ::Domain::Product::Reports::AlignmentPercentage::ByStatus::Header.!
              csv = build table, header
              csv
            end

            def build(table, header)
              csv_string = CSV.generate do |csv|
                csv << header
                table.each do |row|
                  csv << [row.product_title,
                          row.publisher_name,
                          row.product_subject,
                          row.product_grade,

                          row.product_standard,
                          row.product_state_adopted,
                          row.publisher_alignment_percentage,
                          row.ll_alignment_percentage,
                          row.published_at]
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