require_relative '../sketches_init'

main_title 'District case statement'

log = Telemetry::MongoidLog
log.clear!

district = District.first
enrollment = district.total_students

puts enrollment

case enrollment
when 1..249
  puts "1 - 249"
when 250..2499
  puts "250 - 2,499"
when 2500..4999
  puts "2,500 - 4,999"
when 5000..9999
  puts "5,000 - 9,999"
when 10000..14999
  puts "10,000 - 14,999"
when 15000..19999
  puts "15,000 - 19,999"
when 20000..49999
  puts "20,000 - 49,999"
when 50000..99999
  puts "50,000 - 99,000"
end

puts "Finished."


