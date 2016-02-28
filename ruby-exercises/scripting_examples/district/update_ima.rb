require_relative '../script_init'
require 'csv'

main_title 'Update IMA enrollment'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"

    def update_enrollment(ima_school, district)
      unless ima_school["total_students"] == 0
        puts "Previous enrollment:"
        puts district.total_students

        district.total_students = ima_school["total_students"]

        puts "New enrollment:"
        puts ima_school["total_students"]
        district.set(:total_students, ima_school["total_students"])
      end
    end

    def query_school(data)
      school = District.all_of(:school_name => data["school_name"], :zip => data["zip"], :kind => "district_school").first
      # if no school query with regex
      school = District.all_of(:school_name => /#{data["school_name"]}/, :zip => data["zip"], :kind => "district_school").first unless school
      school
    end

    def parse_ima_file(file_path, pattern)
      parsed_counter = 0
      CSV.foreach(file_path) do |row|
        parsed_counter += 1
        row_fields = row
        data = Hash[pattern.zip(row_fields.map {|i| i.include?(',') ? (i.split /, /) : i})] 
        district = query_school(data)
        if district
          puts "#{parsed_counter}. #{district.school_name}"
          update_enrollment(data, district)
        end
      end
      puts "\nParsed #{parsed_counter} schools"
    end

    puts 'Create IMA Data'
    pattern = %w(school_name zip total_students state_abbr)
    parse_ima_file('districts_csv/2015_ima.csv', pattern)

    puts "\n---------------------------------\n\n"
    puts "Finish parsing schools."
    puts "\n---------------------------------\n\n"
  end
end