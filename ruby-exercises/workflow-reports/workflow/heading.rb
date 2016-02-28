module Domain
  module Product
    module Reports
      module Workflow
        class Heading

          def self.!(status)
            instance = new status
            instance.!
          end

          def initialize(status)
            @status = status
          end

          def !
            heading
          end

          def status
            @status
          end

          def heading
            case status
            when 'submitted'
              'Submitted Products'
            when 'editorial_review'
               'Products by Editorial Review'
            when 'assigned_to_first_sme'
              'Assigned to SME 1'
            when 'assigned_to_second_sme'
              'Assigned to SME 2'
            when 'ready_for_preview_period'
              'Ready for Preview'
            when 'preview_period_started'
              'Products in Preview'
            when 'preview_period_has_paused'
              'Preview Paused'
            when 'preview_period_finished'
              'Ready to Publish'
            when 'published'
              'Published Products'
            when 'all'
              'All Products'
            end
          end
        end
      end
    end
  end
end