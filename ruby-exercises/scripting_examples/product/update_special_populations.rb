require_relative '../script_init'

main_title 'Update Component Special Populations'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Products that are new..."

    products = Product.where(state: 'new').all

    products.each do |product|
      product.components.each do |component|
        unless component.special_populations.blank?
          if component.special_populations.include? 'Response to intervention' || 'Students with disabilities' || 'Gifted and talented'

            component.special_populations.each do |sp|
              if sp == 'Response to intervention'
                component.special_populations.map! { |sp| sp = 'Response to Intervention' if sp == 'Response to intervention'}
              elsif sp == 'Students with disabilities'
                component.special_populations.map! { |sp| sp = 'Students with Disabilities' if sp == 'Students with disabilities'}
              elsif sp == 'Gifted and talented'
                component.special_populations.map! { |sp| sp = 'Gifted and Talented' if sp == 'Gifted and talented'}
              end
            end
            component.special_populations.delete_if {|sp| !sp }
            sp = component.special_populations
            component.set(:special_populations, sp)

            puts "Product:"
            puts product.title
            puts "URL:"
            puts component.purchasing_url
          end
        end
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are new."

    puts "\n====================================\n\n"
    puts "Products that are submitted..."

    products = Product.where(state: 'submitted').all

    products.each do |product|
      product.components.each do |component|
        unless component.special_populations.blank?
          if component.special_populations.include? 'Response to intervention' || 'Students with disabilities' || 'Gifted and talented'

            component.special_populations.each do |sp|
              if sp == 'Response to intervention'
                component.special_populations.map! { |sp| sp = 'Response to Intervention' if sp == 'Response to intervention'}
              elsif sp == 'Students with disabilities'
                component.special_populations.map! { |sp| sp = 'Students with Disabilities' if sp == 'Students with disabilities'}
              elsif sp == 'Gifted and talented'
                component.special_populations.map! { |sp| sp = 'Gifted and Talented' if sp == 'Gifted and talented'}
              end
            end
            component.special_populations.delete_if {|sp| !sp }
            sp = component.special_populations
            component.set(:special_populations, sp)

            puts "Product:"
            puts product.title
            puts "URL:"
            puts component.purchasing_url
          end
        end
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are submitted."

    puts "\n====================================\n\n"
    puts "Products that are ready for publisher..."

    products = Product.where(state: 'ready_for_publisher').all

    products.each do |product|
      product.components.each do |component|
        unless component.special_populations.blank?
          if component.special_populations.include? 'Response to intervention' || 'Students with disabilities' || 'Gifted and talented'

            component.special_populations.each do |sp|
              if sp == 'Response to intervention'
                component.special_populations.map! { |sp| sp = 'Response to Intervention' if sp == 'Response to intervention'}
              elsif sp == 'Students with disabilities'
                component.special_populations.map! { |sp| sp = 'Students with Disabilities' if sp == 'Students with disabilities'}
              elsif sp == 'Gifted and talented'
                component.special_populations.map! { |sp| sp = 'Gifted and Talented' if sp == 'Gifted and talented'}
              end
            end
            component.special_populations.delete_if {|sp| !sp }
            sp = component.special_populations
            component.set(:special_populations, sp)

            puts "Product:"
            puts product.title
            puts "URL:"
            puts component.purchasing_url
          end
        end
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are ready for publisher."

    puts "\n====================================\n\n"
    puts "Products that are in preview period..."

    products = Product.where(state: 'preview_period').all

    products.each do |product|
      product.components.each do |component|
        unless component.special_populations.blank?
          if component.special_populations.include? 'Response to intervention' || 'Students with disabilities' || 'Gifted and talented'

            component.special_populations.each do |sp|
              if sp == 'Response to intervention'
                component.special_populations.map! { |sp| sp = 'Response to Intervention' if sp == 'Response to intervention'}
              elsif sp == 'Students with disabilities'
                component.special_populations.map! { |sp| sp = 'Students with Disabilities' if sp == 'Students with disabilities'}
              elsif sp == 'Gifted and talented'
                component.special_populations.map! { |sp| sp = 'Gifted and Talented' if sp == 'Gifted and talented'}
              end
            end
            component.special_populations.delete_if {|sp| !sp }
            sp = component.special_populations
            component.set(:special_populations, sp)

            puts "Product:"
            puts product.title
            puts "URL:"
            puts component.purchasing_url
          end
        end
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are in preview period."


    puts "\n====================================\n\n"
    puts "Products that are at review period has stopped..."

    products = Product.where(state: 'preview_period_has_stopped').all

    products.each do |product|
      product.components.each do |component|
        unless component.special_populations.blank?
          if component.special_populations.include? 'Response to intervention' || 'Students with disabilities' || 'Gifted and talented'

            component.special_populations.each do |sp|
              if sp == 'Response to intervention'
                component.special_populations.map! { |sp| sp = 'Response to Intervention' if sp == 'Response to intervention'}
              elsif sp == 'Students with disabilities'
                component.special_populations.map! { |sp| sp = 'Students with Disabilities' if sp == 'Students with disabilities'}
              elsif sp == 'Gifted and talented'
                component.special_populations.map! { |sp| sp = 'Gifted and Talented' if sp == 'Gifted and talented'}
              end
            end
            component.special_populations.delete_if {|sp| !sp }
            sp = component.special_populations
            component.set(:special_populations, sp)

            puts "Product:"
            puts product.title
            puts "URL:"
            puts component.purchasing_url
          end
        end
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are at review period has stopped."


    puts "\n====================================\n\n"
    puts "Products that are preview finished..."

    products = Product.where(state: 'preview_finished').all

    products.each do |product|
      product.components.each do |component|
        unless component.special_populations.blank?
          if component.special_populations.include? 'Response to intervention' || 'Students with disabilities' || 'Gifted and talented'

            component.special_populations.each do |sp|
              if sp == 'Response to intervention'
                component.special_populations.map! { |sp| sp = 'Response to Intervention' if sp == 'Response to intervention'}
              elsif sp == 'Students with disabilities'
                component.special_populations.map! { |sp| sp = 'Students with Disabilities' if sp == 'Students with disabilities'}
              elsif sp == 'Gifted and talented'
                component.special_populations.map! { |sp| sp = 'Gifted and Talented' if sp == 'Gifted and talented'}
              end
            end
            component.special_populations.delete_if {|sp| !sp }
            sp = component.special_populations
            component.set(:special_populations, sp)

            puts "Product:"
            puts product.title
            puts "URL:"
            puts component.purchasing_url
          end
        end
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are preview finished."


    puts "\n====================================\n\n"
    puts "Products that are published..."

    products = Product.where(state: 'published').all

    products.each do |product|
      product.components.each do |component|
        unless component.special_populations.blank?
          if component.special_populations.include? 'Response to intervention' || 'Students with disabilities' || 'Gifted and talented'

            component.special_populations.each do |sp|
              if sp == 'Response to intervention'
                component.special_populations.map! { |sp| sp = 'Response to Intervention' if sp == 'Response to intervention'}
              elsif sp == 'Students with disabilities'
                component.special_populations.map! { |sp| sp = 'Students with Disabilities' if sp == 'Students with disabilities'}
              elsif sp == 'Gifted and talented'
                component.special_populations.map! { |sp| sp = 'Gifted and Talented' if sp == 'Gifted and talented'}
              end
            end
            component.special_populations.delete_if {|sp| !sp }
            sp = component.special_populations
            component.set(:special_populations, sp)

            puts "Product:"
            puts product.title
            puts "URL:"
            puts component.purchasing_url
          end
        end
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are published."


    puts "\n====================================\n\n"
    puts "Products that are unpublished..."

    products = Product.where(state: 'unpublished').all

    products.each do |product|
      product.components.each do |component|
        unless component.special_populations.blank?
          if component.special_populations.include? 'Response to intervention' || 'Students with disabilities' || 'Gifted and talented'

            component.special_populations.each do |sp|
              if sp == 'Response to intervention'
                component.special_populations.map! { |sp| sp = 'Response to Intervention' if sp == 'Response to intervention'}
              elsif sp == 'Students with disabilities'
                component.special_populations.map! { |sp| sp = 'Students with Disabilities' if sp == 'Students with disabilities'}
              elsif sp == 'Gifted and talented'
                component.special_populations.map! { |sp| sp = 'Gifted and Talented' if sp == 'Gifted and talented'}
              end
            end

            component.special_populations.delete_if {|sp| !sp }
            sp = component.special_populations
            component.set(:special_populations, sp)

            puts "Product:"
            puts product.title
            puts "URL:"
            puts component.purchasing_url
          end
        end
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are unpublished."


  end
end