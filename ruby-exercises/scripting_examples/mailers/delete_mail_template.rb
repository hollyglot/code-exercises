require_relative '../script_init'

main_title 'Delete webinar request mailer'

MailTemplate.where(number: '#34').delete_all

puts "\n-------------------------------------------------------\n\n"
puts "Deleted."
puts "\n-------------------------------------------------------\n\n"
