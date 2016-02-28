module Domain
  module Product
    module Reports
      module Comparison
        module DeviceCompatibilityBuilder
          extend self

          def !(product)
            build_compatibility_text(product)
          end

          def build_compatibility_text(product)
            product.first_component.material_format.delete_if { |mf| mf.blank? }
            text = ""
            if product.first_component.material_format.length == 1
              if product.first_component.material_format.include? "Print"
                text += "Not applicable for this product."
              elsif product.first_component.compatible_devices.present?
                unless product.first_component.compatible_devices.include? "The publisher has not submitted this information to Learning List."
                  text += "This material"
                  if product.first_component.device_agnostic
                    text += " is rendered with HTML5 and"
                  end

                  text += " is compatible with the following devices:"
                  cd = product.first_component.compatible_devices.gsub("</li>", "</li> \n")
                  text += Nokogiri::HTML(cd).text
                else
                  text += "The publisher has not submitted this information to Learning List."
                end
              else
                text += "The publisher has not submitted this information to Learning List."
              end
            elsif product.first_component.compatible_devices.present?
              unless product.first_component.compatible_devices.include? "The publisher has not submitted this information to Learning List."
                text += "This material"
                if product.first_component.device_agnostic
                  text += " is rendered with HTML5 and"
                end

                text += " is compatible with the following devices:"
                cd = product.first_component.compatible_devices.gsub("</li>", "</li> \n")
                text += Nokogiri::HTML(cd).text
              else
                text += "The publisher has not submitted this information to Learning List."
              end
            else
              text += "The publisher has not submitted this information to Learning List."
            end

            text
          end
        end
      end
    end
  end
end