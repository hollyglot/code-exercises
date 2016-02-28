module Domain
  module Product
    module Reports
      module AlignmentPercentage
        module ByStatus
          class Row
            attr_accessor :product_title,
                          :published_at,
                          :product_subject,
                          :product_grade,
                          :product_standard,
                          :product_state_adopted

            attr_accessor :publisher_name,
                          :publisher_alignment_percentage

            attr_accessor :ll_alignment_percentage
          end
        end
      end
    end
  end
end