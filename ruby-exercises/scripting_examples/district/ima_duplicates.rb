require_relative '../script_init'
require 'csv'

main_title 'Find IMA schools with same name'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"

    def parse_ima_file(file_path, pattern)
      previous_school = nil
      parsed_counter = 0
      CSV.foreach(file_path) do |row|
        parsed_counter += 1
        row_fields = row
        data = Hash[pattern.zip(row_fields.map {|i| i.include?(',') ? (i.split /, /) : i})] 
        if data["school_name"] == previous_school
          puts data["school_name"]
          puts previous_school
        end

        previous_school = data["school_name"]
      end
      puts "\nParsed #{parsed_counter} schools"
    end

    puts 'Parse IMA Data'
    pattern = %w(school_name zip total_students state_abbr)
    parse_ima_file('districts_csv/2015_ima.csv', pattern)

    puts "\n---------------------------------\n\n"
    puts "Finish parsing schools."
    puts "\n---------------------------------\n\n"
  end
end