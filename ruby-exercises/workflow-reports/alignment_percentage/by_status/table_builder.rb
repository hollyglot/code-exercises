module Domain
  module Product
    module Reports
      module AlignmentPercentage
        module ByStatus
          class TableBuilder

            def self.!(status)
              instance = build status
              instance.!
            end

            def self.build(status)
              products = ::Domain::Product::Queries::ByStatus.! status
              TableBuilder.new products
            end

            def initialize(products)
              @products = products
            end

            def !
              rows = []
              @products.each do |product|
                rows.push *build_rows(product)
              end
              rows.sort! { |a,b| a.product_title <=> b.product_title }
              rows
            end

            def build_rows(product)
              if product.alignment_reports.empty?
                build_row product
              else
                build_rows_by_alignment_report product
              end
            end

            def build_rows_by_alignment_report(product)
              rows = []
              product.alignment_reports.each do |alignment_report|
                rows << build_row(product, alignment_report)
              end
              rows
            end

            def build_row(product, alignment_report=nil)
              RowBuilder.! product, alignment_report
            end
          end
        end
      end
    end
  end
end