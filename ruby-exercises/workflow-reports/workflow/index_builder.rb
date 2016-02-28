module Domain
  module Product
    module Reports
      module Workflow
        class IndexBuilder

          def self.!
            instance = build
            instance.!
          end

          def self.build
            products = ::Product.all
            IndexBuilder.new products
          end

          def initialize(products)
            @products = products
            @workflow_index = Index.new
          end

          def !
            records = get_workflow_records
            index_records records
          end

          def index_records(records)
            records.each do |record|
              response = @workflow_index.save(record)
              if response["created"]
                product = ::Product.find record.product_id
                if product.workflow_ids
                  unless product.workflow_ids.include? response["_id"]
                    product.push(:workflow_ids, response["_id"])
                  end
                else
                  product.push(:workflow_ids, response["_id"])
                end
              end

            end
          end

          def get_workflow_records
            records = []
            @products.each do |product|
              records.push *build_records(product)
            end
            records
          end

          def build_records(product)
            if product.alignment_reports.empty?
              record = []
              record << build_record(product)
              record
            else
              build_record_by_alignment_report product
            end
          end

          def build_record_by_alignment_report(product)
            records = []
            product.alignment_reports.each do |alignment_report|
              records << build_record(product, alignment_report)
            end
            records
          end

          def build_record(product, alignment_report=nil)
            ::Domain::Product::Reports::Workflow::Records::Builder.! product, alignment_report
          end

        end
      end
    end
  end
end