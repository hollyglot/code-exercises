require_relative '../script_init'

main_title 'Migrate Components TEKS and CCSS alignment percentages'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Products that are new..."

    products = Product.where(state: 'new').all

    products.each do |product|
      alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
      alignment_report = alignment_reports.first
      alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
      standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
      product.components.each do |component|
        if standard
          if standard.name == 'CCSS'
            component.alignment_percentage = component.percent_common_core_covered if component.respond_to? :percent_common_core_covered
          elsif standard.name == 'TEKS'
            component.alignment_percentage = component.percent_teks_covered if component.respond_to? :percent_teks_covered
          end
        end
        puts "\n------------------------------------------\n\n"
        puts "Product:"
        puts product.title
        puts "Percentage:"
        puts component.alignment_percentage
        product.save
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are new."

    puts "\n====================================\n\n"
    puts "Products that are submitted..."

    products = Product.where(state: 'submitted').all

    products.each do |product|
      alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
      alignment_report = alignment_reports.first
      alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
      standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
      product.components.each do |component|
        if standard
          if standard.name == 'CCSS'
            component.alignment_percentage = component.percent_common_core_covered if component.respond_to? :percent_common_core_covered
          elsif standard.name == 'TEKS'
            component.alignment_percentage = component.percent_teks_covered if component.respond_to? :percent_teks_covered
          end
        end
        puts "\n------------------------------------------\n\n"
        puts "Product:"
        puts product.title
        puts "Percentage:"
        puts component.alignment_percentage
        product.save
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are submitted."

    puts "\n====================================\n\n"
    puts "Products that are ready for publisher..."

    products = Product.where(state: 'ready_for_publisher').all

    products.each do |product|
      alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
      alignment_report = alignment_reports.first
      alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
      standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
      product.components.each do |component|
        if standard
          if standard.name == 'CCSS'
            component.alignment_percentage = component.percent_common_core_covered if component.respond_to? :percent_common_core_covered
          elsif standard.name == 'TEKS'
            component.alignment_percentage = component.percent_teks_covered if component.respond_to? :percent_teks_covered
          end
        end
        puts "\n------------------------------------------\n\n"
        puts "Product:"
        puts product.title
        puts "Percentage:"
        puts component.alignment_percentage
        product.save
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are ready for publisher."

    puts "\n====================================\n\n"
    puts "Products that are in preview period..."

    products = Product.where(state: 'preview_period').all

    products.each do |product|
      alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
      alignment_report = alignment_reports.first
      alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
      standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
      product.components.each do |component|
        if standard
          if standard.name == 'CCSS'
            component.alignment_percentage = component.percent_common_core_covered if component.respond_to? :percent_common_core_covered
          elsif standard.name == 'TEKS'
            component.alignment_percentage = component.percent_teks_covered if component.respond_to? :percent_teks_covered
          end
        end
        puts "\n------------------------------------------\n\n"
        puts "Product:"
        puts product.title
        puts "Percentage:"
        puts component.alignment_percentage
        product.save
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are in preview period."


    puts "\n====================================\n\n"
    puts "Products that are at review period has stopped..."

    products = Product.where(state: 'preview_period_has_stopped').all

    products.each do |product|
      alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
      alignment_report = alignment_reports.first
      alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
      standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
      product.components.each do |component|
        if standard
          if standard.name == 'CCSS'
            component.alignment_percentage = component.percent_common_core_covered if component.respond_to? :percent_common_core_covered
          elsif standard.name == 'TEKS'
            component.alignment_percentage = component.percent_teks_covered if component.respond_to? :percent_teks_covered
          end
        end
        puts "\n------------------------------------------\n\n"
        puts "Product:"
        puts product.title
        puts "Percentage:"
        puts component.alignment_percentage
        product.save
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are at review period has stopped."


    puts "\n====================================\n\n"
    puts "Products that are preview finished..."

    products = Product.where(state: 'preview_finished').all

    products.each do |product|
      alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
      alignment_report = alignment_reports.first
      alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
      standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
      product.components.each do |component|
        if standard
          if standard.name == 'CCSS'
            component.alignment_percentage = component.percent_common_core_covered if component.respond_to? :percent_common_core_covered
          elsif standard.name == 'TEKS'
            component.alignment_percentage = component.percent_teks_covered if component.respond_to? :percent_teks_covered
          end
        end
        puts "\n------------------------------------------\n\n"
        puts "Product:"
        puts product.title
        puts "Percentage:"
        puts component.alignment_percentage
        product.save
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are preview finished."


    puts "\n====================================\n\n"
    puts "Products that are published..."

    products = Product.where(state: 'published').all

    products.each do |product|
      alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
      alignment_report = alignment_reports.first
      alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
      standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
      product.components.each do |component|
        if standard
          if standard.name == 'CCSS'
            component.alignment_percentage = component.percent_common_core_covered if component.respond_to? :percent_common_core_covered
          elsif standard.name == 'TEKS'
            component.alignment_percentage = component.percent_teks_covered if component.respond_to? :percent_teks_covered
          end
        end
        puts "\n------------------------------------------\n\n"
        puts "Product:"
        puts product.title
        puts "Percentage:"
        puts component.alignment_percentage
        product.save
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are published."


    puts "\n====================================\n\n"
    puts "Products that are unpublished..."

    products = Product.where(state: 'unpublished').all

    products.each do |product|
      alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
      alignment_report = alignment_reports.first
      alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
      standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
      product.components.each do |component|
        if standard
          if standard.name == 'CCSS'
            component.alignment_percentage = component.percent_common_core_covered if component.respond_to? :percent_common_core_covered
          elsif standard.name == 'TEKS'
            component.alignment_percentage = component.percent_teks_covered if component.respond_to? :percent_teks_covered
          end
        end
        puts "\n------------------------------------------\n\n"
        puts "Product:"
        puts product.title
        puts "Percentage:"
        puts component.alignment_percentage
        product.save
      end
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are unpublished."


  end
end