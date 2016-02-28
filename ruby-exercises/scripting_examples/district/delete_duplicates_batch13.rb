require_relative '../script_init'

main_title 'Delete Duplicate District Records'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"

    puts "Processing records 120,001 - 130,000"

    i = 0
    item_num = 120001
    item_offset = 200
    offset = 100
    limit = 100
    times = 100

    begin
      schools = District.limit(limit).skip(offset * item_offset).desc(:school_name)

      schools.each do |school|

        # make sure school hasn't been deleted already
        school = District.where(id: school.id).first

        if school
          puts "\n====================================="
          puts "Finding duplicates:\n"
          puts "#{item_num}. #{school.school_name}\n"


          districts = ::District.all_of(:school_name => school.school_name, :zip => school.zip, :kind => school.kind, :state => school.state, :county => school.county, :id.ne => school.id).to_a

          if districts.length > 0
            organization_belongs_to_duplicate = false

            puts "Duplicates found!"
            puts school.id

            districts.each do |district|

              # check if organization belongs to district
              organization = Organization.where(district_id: district.id).first

              unless organization
                puts "Deleting duplicate"
                district.delete
              else
                organization_belongs_to_duplicate = true
              end
            end

            if organization_belongs_to_duplicate
              puts "Deleting original because duplicate has organization"
              school.delete
            end
            
          else
            puts "No duplicates"
          end
          puts "\n====================================="
        end

        item_num +=1
      end

      item_offset +=1
      i +=1
    end until i == times

    puts "\n---------------------------------\n\n"
    puts "Finished deleting duplicates."
    puts "\n---------------------------------\n\n"
  end
end