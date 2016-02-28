module Domain
  module Product
    module Reports
      module Workflow
        module Records
          module Delete
            class ByAlignmentReport

              def self.!(alignment_report_id, product)
                instance = new alignment_report_id, product
                instance.!
              end

              def initialize(alignment_report_id, product)
                @product = product
                @alignment_report_id = alignment_report_id
                @workflow_index = ::Domain::Product::Reports::Workflow::Index.new
              end

              def product
                @product
              end

              def alignment_report_id
                @alignment_report_id
              end

              def !
                delete_record
              end

              def delete_record
                product.workflow_ids.each do |id|
                  record = @workflow_index.search(query: { ids: { values: [id]}})
                  if record.total > 0
                    if record.first.alignment_report_id && record.first.alignment_report_id == alignment_report_id.to_s
                      @workflow_index.delete(id: id)
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
end