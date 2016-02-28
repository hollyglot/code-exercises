require_relative '../script_init'

main_title 'Migrate Components TEKS and CCSS Correlations'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n====================================\n\n"
    puts "Products that are new..."

    products = Product.where(state: 'new').all

    products_count = []
    products_with_CCSS = []
    products_with_TEKS = []
    products_with_CCSS_and_TEKS = []
    products.each do |product|
      product.components.each do |component|
        if !component[:common_core_correlations].blank? || !component[:teks_correlations].blank?
          alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
          alignment_report = alignment_reports.first
          alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
          standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
          if standard
            puts "\n------------------------------------------\n\n"
            puts "Product:"
            puts product.title
            puts "Standard:"
            puts standard.name

            products_count << product.title

            if standard.name == 'CCSS'
              puts "Common Core:"
              puts component[:_id]
              component[:publisher_correlations] = component[:common_core_correlations]
              puts component[:common_core_correlations]
              component.publisher_correlations = component.common_core_correlations if component.respond_to? :common_core_correlations
              products_with_CCSS << product.title
            elsif standard.name == 'TEKS'
              puts "TEKS:"
              puts component[:_id]
              component[:publisher_correlations] = component[:teks_correlations]
              puts component[:teks_correlations]
              component.publisher_correlations = component.teks_correlations if component.respond_to? :teks_correlations
              products_with_TEKS << product.title
            end

            product.save
          end
        end
      end
    end

    puts "\n------------------------------------------\n\n"
    puts 'Count:'
    puts products_count.count

    puts "\n------------------------------------------\n\n"
    puts 'Products with TEKS Correlation'
    products_with_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS Correlation'
    products_with_CCSS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS and TEKS Correlation'
    products_with_CCSS_and_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end


    puts "\n====================================\n\n"
    puts "Finished with products that are new."


    puts "\n====================================\n\n"
    puts "Products that are submitted..."

    products = Product.where(state: 'submitted').all

    products_count = []
    products_with_CCSS = []
    products_with_TEKS = []
    products_with_CCSS_and_TEKS = []
    products.each do |product|
      product.components.each do |component|
        if !component[:common_core_correlations].blank? || !component[:teks_correlations].blank?
          alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
          alignment_report = alignment_reports.first
          alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
          standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
          if standard
            puts "\n------------------------------------------\n\n"
            puts "Product:"
            puts product.title
            puts "Standard:"
            puts standard.name

            products_count << product.title

            if standard.name == 'CCSS'
              puts "Common Core:"
              puts component[:_id]
              component[:publisher_correlations] = component[:common_core_correlations]
              puts component[:common_core_correlations]
              component.publisher_correlations = component.common_core_correlations if component.respond_to? :common_core_correlations
              products_with_CCSS << product.title
            elsif standard.name == 'TEKS'
              puts "TEKS:"
              puts component[:_id]
              component[:publisher_correlations] = component[:teks_correlations]
              puts component[:teks_correlations]
              component.publisher_correlations = component.teks_correlations if component.respond_to? :teks_correlations
              products_with_TEKS << product.title
            end

            product.save
          end
        end
      end
    end

    puts "\n------------------------------------------\n\n"
    puts 'Count:'
    puts products_count.count

    puts "\n------------------------------------------\n\n"
    puts 'Products with TEKS Correlation'
    products_with_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS Correlation'
    products_with_CCSS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS and TEKS Correlation'
    products_with_CCSS_and_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end


    puts "\n====================================\n\n"
    puts "Finished with products that are submitted."



    puts "\n====================================\n\n"
    puts "Products that are ready for publisher..."

    products = Product.where(state: 'ready_for_publisher').all

    products_count = []
    products_with_CCSS = []
    products_with_TEKS = []
    products_with_CCSS_and_TEKS = []
    products.each do |product|
      product.components.each do |component|
        if !component[:common_core_correlations].blank? || !component[:teks_correlations].blank?
          alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
          alignment_report = alignment_reports.first
          alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
          standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
          if standard
            puts "\n------------------------------------------\n\n"
            puts "Product:"
            puts product.title
            puts "Standard:"
            puts standard.name

            products_count << product.title

            if standard.name == 'CCSS'
              puts "Common Core:"
              puts component[:_id]
              component[:publisher_correlations] = component[:common_core_correlations]
              puts component[:common_core_correlations]
              component.publisher_correlations = component.common_core_correlations if component.respond_to? :common_core_correlations
              products_with_CCSS << product.title
            elsif standard.name == 'TEKS'
              puts "TEKS:"
              puts component[:_id]
              component[:publisher_correlations] = component[:teks_correlations]
              puts component[:teks_correlations]
              component.publisher_correlations = component.teks_correlations if component.respond_to? :teks_correlations
              products_with_TEKS << product.title
            end

            product.save
          end
        end
      end
    end

    puts "\n------------------------------------------\n\n"
    puts 'Count:'
    puts products_count.count

    puts "\n------------------------------------------\n\n"
    puts 'Products with TEKS Correlation'
    products_with_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS Correlation'
    products_with_CCSS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS and TEKS Correlation'
    products_with_CCSS_and_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end


    puts "\n====================================\n\n"
    puts "Finished with products that are ready for publisher."



    puts "\n====================================\n\n"
    puts "Products that are in preview period..."

    products = Product.where(state: 'preview_period').all

    products_count = []
    products_with_CCSS = []
    products_with_TEKS = []
    products_with_CCSS_and_TEKS = []
    products.each do |product|
      product.components.each do |component|
        if !component[:common_core_correlations].blank? || !component[:teks_correlations].blank?
          alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
          alignment_report = alignment_reports.first
          alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
          standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
          if standard
            puts "\n------------------------------------------\n\n"
            puts "Product:"
            puts product.title
            puts "Standard:"
            puts standard.name

            products_count << product.title

            if standard.name == 'CCSS'
              puts "Common Core:"
              puts component[:_id]
              component[:publisher_correlations] = component[:common_core_correlations]
              puts component[:common_core_correlations]
              component.publisher_correlations = component.common_core_correlations if component.respond_to? :common_core_correlations
              products_with_CCSS << product.title
            elsif standard.name == 'TEKS'
              puts "TEKS:"
              puts component[:_id]
              component[:publisher_correlations] = component[:teks_correlations]
              puts component[:teks_correlations]
              component.publisher_correlations = component.teks_correlations if component.respond_to? :teks_correlations
              products_with_TEKS << product.title
            end

            product.save
          end
        end
      end
    end

    puts "\n------------------------------------------\n\n"
    puts 'Count:'
    puts products_count.count

    puts "\n------------------------------------------\n\n"
    puts 'Products with TEKS Correlation'
    products_with_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS Correlation'
    products_with_CCSS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS and TEKS Correlation'
    products_with_CCSS_and_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end



    puts "\n====================================\n\n"
    puts "Finished with products that are in preview period."


    puts "\n====================================\n\n"
    puts "Products that are at review period has stopped..."

    products = Product.where(state: 'preview_period_has_stopped').all

    products_count = []
    products_with_CCSS = []
    products_with_TEKS = []
    products_with_CCSS_and_TEKS = []
    products.each do |product|
      product.components.each do |component|
        if !component[:common_core_correlations].blank? || !component[:teks_correlations].blank?
          alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
          alignment_report = alignment_reports.first
          alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
          standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
          if standard
            puts "\n------------------------------------------\n\n"
            puts "Product:"
            puts product.title
            puts "Standard:"
            puts standard.name

            products_count << product.title

            if standard.name == 'CCSS'
              puts "Common Core:"
              puts component[:_id]
              component[:publisher_correlations] = component[:common_core_correlations]
              puts component[:common_core_correlations]
              component.publisher_correlations = component.common_core_correlations if component.respond_to? :common_core_correlations
              products_with_CCSS << product.title
            elsif standard.name == 'TEKS'
              puts "TEKS:"
              puts component[:_id]
              component[:publisher_correlations] = component[:teks_correlations]
              puts component[:teks_correlations]
              component.publisher_correlations = component.teks_correlations if component.respond_to? :teks_correlations
              products_with_TEKS << product.title
            end

            product.save
          end
        end
      end
    end

    puts "\n------------------------------------------\n\n"
    puts 'Count:'
    puts products_count.count

    puts "\n------------------------------------------\n\n"
    puts 'Products with TEKS Correlation'
    products_with_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS Correlation'
    products_with_CCSS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS and TEKS Correlation'
    products_with_CCSS_and_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are at review period has stopped."



    puts "\n====================================\n\n"
    puts "Products that are preview finished..."

    products = Product.where(state: 'preview_finished').all

    products_count = []
    products_with_CCSS = []
    products_with_TEKS = []
    products_with_CCSS_and_TEKS = []
    products.each do |product|
      product.components.each do |component|
        if !component[:common_core_correlations].blank? || !component[:teks_correlations].blank?
          alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
          alignment_report = alignment_reports.first
          alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
          standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
          if standard
            puts "\n------------------------------------------\n\n"
            puts "Product:"
            puts product.title
            puts "Standard:"
            puts standard.name

            products_count << product.title

            if standard.name == 'CCSS'
              puts "Common Core:"
              puts component[:_id]
              component[:publisher_correlations] = component[:common_core_correlations]
              puts component[:common_core_correlations]
              component.publisher_correlations = component.common_core_correlations if component.respond_to? :common_core_correlations
              products_with_CCSS << product.title
            elsif standard.name == 'TEKS'
              puts "TEKS:"
              puts component[:_id]
              component[:publisher_correlations] = component[:teks_correlations]
              puts component[:teks_correlations]
              component.publisher_correlations = component.teks_correlations if component.respond_to? :teks_correlations
              products_with_TEKS << product.title
            end

            product.save
          end
        end
      end
    end

    puts "\n------------------------------------------\n\n"
    puts 'Count:'
    puts products_count.count

    puts "\n------------------------------------------\n\n"
    puts 'Products with TEKS Correlation'
    products_with_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS Correlation'
    products_with_CCSS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS and TEKS Correlation'
    products_with_CCSS_and_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end


    puts "\n====================================\n\n"
    puts "Finished with products that are preview finished."


    puts "\n====================================\n\n"
    puts "Products that are published..."

    products = Product.where(state: 'published').all

    products_count = []
    products_with_CCSS = []
    products_with_TEKS = []
    products_with_CCSS_and_TEKS = []
    products.each do |product|
      product.components.each do |component|
        if !component[:common_core_correlations].blank? || !component[:teks_correlations].blank?
          alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
          alignment_report = alignment_reports.first
          alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
          standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
          if standard
            puts "\n------------------------------------------\n\n"
            puts "Product:"
            puts product.title
            puts "Standard:"
            puts standard.name

            products_count << product.title

            if standard.name == 'CCSS'
              puts "Common Core:"
              puts component[:_id]
              component[:publisher_correlations] = component[:common_core_correlations]
              puts component[:common_core_correlations]
              component.publisher_correlations = component.common_core_correlations if component.respond_to? :common_core_correlations
              products_with_CCSS << product.title
            elsif standard.name == 'TEKS'
              puts "TEKS:"
              puts component[:_id]
              component[:publisher_correlations] = component[:teks_correlations]
              puts component[:teks_correlations]
              component.publisher_correlations = component.teks_correlations if component.respond_to? :teks_correlations
              products_with_TEKS << product.title
            end

            product.save
          end
        end
      end
    end

    puts "\n------------------------------------------\n\n"
    puts 'Count:'
    puts products_count.count

    puts "\n------------------------------------------\n\n"
    puts 'Products with TEKS Correlation'
    products_with_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS Correlation'
    products_with_CCSS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS and TEKS Correlation'
    products_with_CCSS_and_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end


    puts "\n====================================\n\n"
    puts "Finished with products that are published."


    puts "\n====================================\n\n"
    puts "Products that are unpublished..."

    products = Product.where(state: 'unpublished').all
    products_count = []
    products_with_CCSS = []
    products_with_TEKS = []
    products_with_CCSS_and_TEKS = []
    products.each do |product|
      product.components.each do |component|
        if !component[:common_core_correlations].blank? || !component[:teks_correlations].blank?
          alignment_reports = ::Domain::AlignmentReport::Queries::ByProduct.! product
          alignment_report = alignment_reports.first
          alignment_template = ::Domain::AlignmentTemplate::Queries::AlignmentTemplate.! alignment_report.alignment_template_id if alignment_report
          standard = ::Domain::Standard::Queries::Standard.! alignment_template.standard_id if alignment_template
          if standard
            puts "\n------------------------------------------\n\n"
            puts "Product:"
            puts product.title
            puts "Standard:"
            puts standard.name

            products_count << product.title

            if standard.name == 'CCSS'
              puts "Common Core:"
              puts component[:_id]
              component[:publisher_correlations] = component[:common_core_correlations]
              puts component[:common_core_correlations]
              component.publisher_correlations = component.common_core_correlations if component.respond_to? :common_core_correlations
              products_with_CCSS << product.title
            elsif standard.name == 'TEKS'
              puts "TEKS:"
              puts component[:_id]
              component[:publisher_correlations] = component[:teks_correlations]
              puts component[:teks_correlations]
              component.publisher_correlations = component.teks_correlations if component.respond_to? :teks_correlations
              products_with_TEKS << product.title
            end

            product.save
          end
        end
      end
    end

    puts "\n------------------------------------------\n\n"
    puts 'Count:'
    puts products_count.count

    puts "\n------------------------------------------\n\n"
    puts 'Products with TEKS Correlation'
    products_with_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS Correlation'
    products_with_CCSS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n------------------------------------------\n\n"
    puts 'Products with CCSS and TEKS Correlation'
    products_with_CCSS_and_TEKS.each_with_index do |p, i|
      puts "#{i+1}. #{p}"
    end

    puts "\n====================================\n\n"
    puts "Finished with products that are published."


  end
end
