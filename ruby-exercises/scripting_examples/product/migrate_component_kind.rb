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
        if component.kind = "print_or_physical_media"
          material_format = ["Print"]
        elsif component.kind = "online_instructional_material"
          material_format = ["Online"]
        elsif component.kind = "online_interactive_course"
          material_format = ["Online Interactive Course, (e.g. with live teacher)"]
        else
          puts product.title + " has " + component.kind + " as its kind."
        end

        er = product.product_review

        if er && er.intro
          if er.intro.include? 'online'
            material_format << "Online" unless material_format.include? "Online"
          elsif er.intro.include? 'print'
            material_format << "Print" unless material_format.include? "Print"
          end
        end

        puts "Product:"
        puts product.title
        puts "URL:"
        puts component.purchasing_url
        puts material_format
        puts "\n------------------------------------------\n\n"
        component.set(:material_format, material_format)
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are new."

    puts "\n====================================\n\n"
    puts "Products that are submitted..."

    products = Product.where(state: 'submitted').all

    products.each do |product|
      product.components.each do |component|
        if component.kind = "print_or_physical_media"
          material_format = ["Print"]
        elsif component.kind = "online_instructional_material"
          material_format = ["Online"]
        elsif component.kind = "online_interactive_course"
          material_format = ["Online Interactive Course, (e.g. with live teacher)"]
        else
          puts product.title + " has " + component.kind + " as its kind."
        end

        er = product.product_review

        if er && er.intro
          if er.intro.include? 'online'
            material_format << "Online" unless material_format.include? "Online"
          elsif er.intro.include? 'print'
            material_format << "Print" unless material_format.include? "Print"
          end
        end

        puts "Product:"
        puts product.title
        puts "URL:"
        puts component.purchasing_url
        puts material_format
        puts "\n------------------------------------------\n\n"
        component.set(:material_format, material_format)
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are submitted."

    puts "\n====================================\n\n"
    puts "Products that are ready for publisher..."

    products = Product.where(state: 'ready_for_publisher').all

    products.each do |product|
      product.components.each do |component|
        if component.kind = "print_or_physical_media"
          material_format = ["Print"]
        elsif component.kind = "online_instructional_material"
          material_format = ["Online"]
        elsif component.kind = "online_interactive_course"
          material_format = ["Online Interactive Course, (e.g. with live teacher)"]
        else
          puts product.title + " has " + component.kind + " as its kind."
        end

        er = product.product_review

        if er && er.intro
          if er.intro.include? 'online'
            material_format << "Online" unless material_format.include? "Online"
          elsif er.intro.include? 'print'
            material_format << "Print" unless material_format.include? "Print"
          end
        end

        puts "Product:"
        puts product.title
        puts "URL:"
        puts component.purchasing_url
        puts material_format
        puts "\n------------------------------------------\n\n"
        component.set(:material_format, material_format)
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are ready for publisher."

    puts "\n====================================\n\n"
    puts "Products that are in preview period..."

    products = Product.where(state: 'preview_period').all

    products.each do |product|
      product.components.each do |component|
        if component.kind = "print_or_physical_media"
          material_format = ["Print"]
        elsif component.kind = "online_instructional_material"
          material_format = ["Online"]
        elsif component.kind = "online_interactive_course"
          material_format = ["Online Interactive Course, (e.g. with live teacher)"]
        else
          puts product.title + " has " + component.kind + " as its kind."
        end

        er = product.product_review

        if er && er.intro
          if er.intro.include? 'online'
            material_format << "Online" unless material_format.include? "Online"
          elsif er.intro.include? 'print'
            material_format << "Print" unless material_format.include? "Print"
          end
        end

        puts "Product:"
        puts product.title
        puts "URL:"
        puts component.purchasing_url
        puts material_format
        puts "\n------------------------------------------\n\n"
        component.set(:material_format, material_format)
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are in preview period."


    puts "\n====================================\n\n"
    puts "Products that are at review period has stopped..."

    products = Product.where(state: 'preview_period_has_stopped').all

    products.each do |product|
      product.components.each do |component|
        if component.kind = "print_or_physical_media"
          material_format = ["Print"]
        elsif component.kind = "online_instructional_material"
          material_format = ["Online"]
        elsif component.kind = "online_interactive_course"
          material_format = ["Online Interactive Course, (e.g. with live teacher)"]
        else
          puts product.title + " has " + component.kind + " as its kind."
        end

        er = product.product_review

        if er && er.intro
          if er.intro.include? 'online'
            material_format << "Online" unless material_format.include? "Online"
          elsif er.intro.include? 'print'
            material_format << "Print" unless material_format.include? "Print"
          end
        end

        puts "Product:"
        puts product.title
        puts "URL:"
        puts component.purchasing_url
        puts material_format
        puts "\n------------------------------------------\n\n"
        component.set(:material_format, material_format)
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are at review period has stopped."


    puts "\n====================================\n\n"
    puts "Products that are preview finished..."

    products = Product.where(state: 'preview_finished').all

    products.each do |product|
      product.components.each do |component|
        if component.kind = "print_or_physical_media"
          material_format = ["Print"]
        elsif component.kind = "online_instructional_material"
          material_format = ["Online"]
        elsif component.kind = "online_interactive_course"
          material_format = ["Online Interactive Course, (e.g. with live teacher)"]
        else
          puts product.title + " has " + component.kind + " as its kind."
        end

        er = product.product_review

        if er && er.intro
          if er.intro.include? 'online'
            material_format << "Online" unless material_format.include? "Online"
          elsif er.intro.include? 'print'
            material_format << "Print" unless material_format.include? "Print"
          end
        end

        puts "Product:"
        puts product.title
        puts "URL:"
        puts component.purchasing_url
        puts material_format
        puts "\n------------------------------------------\n\n"
        component.set(:material_format, material_format)
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are preview finished."


    puts "\n====================================\n\n"
    puts "Products that are published..."

    products = Product.where(state: 'published').all

    products.each do |product|
      product.components.each do |component|
        if component.kind = "print_or_physical_media"
          material_format = ["Print"]
        elsif component.kind = "online_instructional_material"
          material_format = ["Online"]
        elsif component.kind = "online_interactive_course"
          material_format = ["Online Interactive Course, (e.g. with live teacher)"]
        else
          puts product.title + " has " + component.kind + " as its kind."
        end

        er = product.product_review

        if er && er.intro
          if er.intro.include? 'online'
            material_format << "Online" unless material_format.include? "Online"
          elsif er.intro.include? 'print'
            material_format << "Print" unless material_format.include? "Print"
          end
        end

        puts "Product:"
        puts product.title
        puts "URL:"
        puts component.purchasing_url
        puts material_format
        puts "\n------------------------------------------\n\n"
        component.set(:material_format, material_format)
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are published."


    puts "\n====================================\n\n"
    puts "Products that are unpublished..."

    products = Product.where(state: 'unpublished').all

    products.each do |product|
      product.components.each do |component|
        if component.kind = "print_or_physical_media"
          material_format = ["Print"]
        elsif component.kind = "online_instructional_material"
          material_format = ["Online"]
        elsif component.kind = "online_interactive_course"
          material_format = ["Online Interactive Course, (e.g. with live teacher)"]
        else
          puts product.title + " has " + component.kind + " as its kind."
        end

        er = product.product_review

        if er && er.intro
          if er.intro.include? 'online'
            material_format << "Online" unless material_format.include? "Online"
          elsif er.intro.include? 'print'
            material_format << "Print" unless material_format.include? "Print"
          end
        end

        puts "Product:"
        puts product.title
        puts "URL:"
        puts component.purchasing_url
        puts material_format
        puts "\n------------------------------------------\n\n"
        component.set(:material_format, material_format)
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are unpublished."

  end
end