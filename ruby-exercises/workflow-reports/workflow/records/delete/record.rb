module Domain
  module Product
    module Reports
      module Workflow
        module Records
          module Delete
            class Record

              def self.!(workflow_id)
                instance = new workflow_id
                instance.!
              end

              def initialize(workflow_id)
                @id = workflow_id
                @workflow_index = ::Domain::Product::Reports::Workflow::Index.new
              end

              def id
                @id
              end

              def !
                delete_record
              end

              def delete_record
                record = @workflow_index.search(query: { ids: { values: [id]}})
                if record.total > 0
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