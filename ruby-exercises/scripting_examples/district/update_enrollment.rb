require_relative '../script_init'

main_title 'Update district enrollment'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"

    puts "Processing records 0 - 10,000"

    i = 0
    item_num = 1
    item_offset = 0
    offset = 100
    limit = 100
    times = 100

    begin
      imported_schools = ImportedDistrict.limit(limit).skip(offset * item_offset).asc(:school_name)

      imported_schools.each do |imported_school|
        puts "\n====================================="
        puts "Migrating Item:\n"
        puts "#{item_num}. #{imported_school.school_name}\n"

        district = ::District.all_of(:school_name => imported_school.school_name, :zip => imported_school.zip, :kind => imported_school.kind).first
        if district
          puts "Updating school"
          puts imported_school.school_name

          unless imported_school.total_students == 0
            puts "Previous enrollment:"
            puts district.total_students

            district.total_students = imported_school.total_students

            puts "New enrollment:"
            puts imported_school.total_students
            district.set(:total_students, imported_school.total_students)
          end
        else
          puts "\n---------------------------------\n\n"
          puts "Adding school"
          puts imported_school.school_name
          DistrictAddNewSchoolWorker.perform_async(imported_school.id)
        end

        item_num +=1
      end

      item_offset +=1
      i +=1
    end until i == times

    puts "\n---------------------------------\n\n"
    puts "Finished updating enrollment and adding new schools."
    puts "\n---------------------------------\n\n"
  end
end