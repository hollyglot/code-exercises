module Domain
  module Product
    module Reports
      module AlignmentPercentage
        module ByStatus
          module Header
            extend self

            def self.!
              ['Title',
              'Publisher',
              'Subject',
              'Grade',

              'Standard',
              'State Adopted',
              'Publisher Submitted Alignment Percentage',
              'Learning List Alignment Percentage',
              'Date Published']
            end
          end
        end
      end
    end
  end
end