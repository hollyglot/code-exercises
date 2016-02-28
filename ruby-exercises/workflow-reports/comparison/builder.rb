module Domain
	module Product
		module Reports
			module Comparison
				class Builder

          def self.!(products, display_compatibility, subjects, grades, user_price=nil, user_comments=nil)
            instance = new products, display_compatibility, subjects, grades, user_price, user_comments
            instance.!
          end

          def initialize(products, display_compatibility, subjects, grades, user_prices, user_comments)
            @products = products
            @subjects = subjects
            @grades = grades
            @user_prices = user_prices
            @user_comments = user_comments
            @display_compatibility = display_compatibility
          end

          def !
            header = build_header @subjects, @grades
            comparison = {}
            comparison[:header] = header

            products = []
            @products.each_with_index do |product, index|
              price = @user_prices[index] if @user_prices && @user_prices[index].present?
              comment = @user_comments[index] if @user_comments && @user_comments[index].present?
              products << build_comparison_record(product, @display_compatibility, price, comment)
            end

            comparison[:products] = products
            comparison
          end

          def build_header(subjects, grades)

            if grades || subjects
              header = "Comparison of Materials for: "
              if grades
                grades.each do |grade|
                  header += "#{Component::GRADES_FOR_SEARCH[grade]}, "
                end
              end
              header += "Subject: "
              if subjects
                subjects.each_with_index do |subject, i|
                  unless i == (subjects.length - 1)
                    header +=  "#{subject}, "
                  else
                    header +=  "#{subject}"
                  end
                end
              end
            end

            header
          end

          def build_comparison_record(product, display_device_compatibility, user_price=nil, user_comments=nil)
            comparison = ::Domain::Product::Reports::Comparison::Record.new

            # -------------------   Product Fields ---------------------------
            # Product Title
            comparison.title = product.title

            # Product Description
            comparison.description = product.description

            # Product Subject
            comparison.subject = product.first_component.subject.title

            # Product Grade
            comparison.grade = Component::GRADES_FOR_SEARCH[product.first_component.grade]

            # Product State Adopted
            if product.state_verified_correlations.present? && !product.state_alignment?
              comparison.state_adopted = "Yes"
            else
              comparison.state_adopted = "No"
            end

            # Product Format
              comparison.format = product.first_component.material_format.join("; ")

            # Product Type
              comparison.type = product.first_component.material_type.join("; ")

            # Product Pricing
            if user_price
              comparison.unit_price = user_price
            else
              comparison.unit_price = "#{product.first_component.unit_price} #{product.first_component.unit_of_measure}"
            end

            # Product Student Groups Served
            if product.first_component.special_populations
              comparison.student_groups_served = ""
              product.first_component.special_populations.each_with_index do |special_population, i|
                if special_population
                  comparison.student_groups_served += "#{special_population} \n"
                end
              end
            end

            # Product Strengths
            if product.product_review.strengths
              ps = product.product_review.strengths.gsub("</li>", "</li> \n")
              comparison.product_strengths = Nokogiri::HTML(ps).text
            end

            # Product Good to Knows
            if product.product_review.good_to_know
              gtk = product.product_review.good_to_know.gsub("</li>", "</li> \n")
              comparison.good_to_knows = Nokogiri::HTML(gtk).text
            end

            # Product Alignment Report
            if product.publish_without_alignment_report
              comparison.alignment_report = "The state's alignment report for this product will be published once the state adoption process is complete."
            else
              product.finalized_alignment_reports.each_with_index do |report, i|
                # link to state adopted correlation modal
                if product.state_verified_correlations.present?
                  comparison.alignment_report = "State Alignment Report: #{product.state_verified_correlations}"
                else
                  # non-state-adopted Learning List Alignment Report
                  comparison.alignment_report = "#{report.title}: "

                  # Display aligment report percent or supplement text
                  if product.small_standards_subset? && product.first_component.supplemental_replacement_text && product.first_component.supplemental_replacement_text != 'None'
                    comparison.alignment_report += product.first_component.supplemental_replacement_text
                  else
                    show_coverage = report.alignment_template.standard.calculation_level != 0 ? true : false
                    if show_coverage
                      comparison.alignment_report += "#{report.coverage_percent}% aligned"
                    end
                  end
                end
              end
            end

            # Product Who's Using This Product?
            if product.product_review.product_users
              users = product.product_review.product_users.gsub("</li>", "</li> \n")
              comparison.whos_using = Nokogiri::HTML(users).text
            end

            # Product Average Educator Ratings
            ratings = ""
            SurveyRatingData['rating']['variants'].each_with_index do |variant, index|
              if variant.present?
                # Add comma and space unless last iteration
                ratings += "#{variant.last}: #{product.subscribers_rating[index]} \n"
              end
            end
            comparison.average_educator_ratings = ratings

            # Product Technology Requirements
            if product.first_component.required_technology
              tr = product.first_component.required_technology.gsub("</li>", "</li> \n")
              comparison.technology_requirements = Nokogiri::HTML(tr).text
            end

            if display_device_compatibility
              # Product Device Compatibility
              comparison.device_compatibility = Domain::Product::Reports::Comparison::DeviceCompatibilityBuilder.! product
            end

            # Product Publisher Questionnaire
            if product.product_review.publisher_questionnaire
              questionnaire = product.product_review.publisher_questionnaire
              questionnaire_with_formatted_links = ""
              doc = Nokogiri::HTML(questionnaire)

              # Get html links and replace with string, i.e. Questionnaire: http://www.questionnaire.com
              doc.xpath('//a[@href]').each do |link|
                stripped_link = "#{link.text.strip}: #{link['href']}"
                questionnaire_with_formatted_links = questionnaire.gsub(/(?i)<a([^>]+)>(.+?)<\/a>/, stripped_link)
              end
              comparison.publisher_questionnaire = Nokogiri::HTML(questionnaire_with_formatted_links).text
            end

            # Product Comments
            comparison.comments = user_comments

            comparison
          end
				end
			end
		end
	end
end