require_relative '../script_init'
require 'csv'

main_title 'Check for Missing Schools in IMA update'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"

    def query_school(data)
      school = District.all_of(:school_name => data["school_name"], :zip => data["zip"], :kind => "district_school").first
      school = District.all_of(:school_name => /#{data["school_name"]}/, :zip => data["zip"], :kind => "district_school").first unless school
      school
    end

    def parse_ima_file(file_path, pattern)
      parsed_counter = 0
      CSV.foreach(file_path) do |row|
        parsed_counter += 1
        row_fields = row
        data = Hash[pattern.zip(row_fields.map {|i| i.include?(',') ? (i.split /, /) : i})] 
        school = query_school(data)
        unless school
          puts "#{parsed_counter}. #{data.inspect}"
        end
      end
      puts "\nParsed #{parsed_counter} schools"
    end

    puts "Finding schools that don't match the IMA fields..."
    pattern = %w(school_name zip total_students state_abbr)
    parse_ima_file('../../districts_csv/2015_ima.csv', pattern)

    puts "\n---------------------------------\n\n"
    puts "Finish parsing schools."
    puts "\n---------------------------------\n\n"
  end
end