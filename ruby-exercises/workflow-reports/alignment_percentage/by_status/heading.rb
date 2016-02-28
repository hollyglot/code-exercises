module Domain
  module Product
    module Reports
      module AlignmentPercentage
        module ByStatus
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
              when 'assigned'
                'Assigned Products'
              when 'ready_for_publisher_previewing'
                'Products Ready For Preview'
              when 'publisher_previewing'
                'Products in Preview'
              when 'published'
                'Published Products'
              when 'unpublished'
                'Unpublished Products'
              when 'all'
                'All Products'
              end
            end
          end
        end
      end
    end
  end
end