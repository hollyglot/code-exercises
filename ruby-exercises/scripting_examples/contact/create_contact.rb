require_relative '../script_init'

main_title 'Create Contact'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Creating Contact..."

    # contact = Contact.create!(company: "Learning List, Inc.", email: "support@learninglist.com", contact_number: 5128522131, fax: 5124828658)


    # puts "Contact:"
    # puts contact.inspect

    # puts "Creating Contact Address..."
    # address = contact.build_address(street: "406 E. 11th St.", unit: "305", city: "Austin", state: "TX", zip: "78701")
    # address.save

    # contact = Contact.create!(first_name: 'Jesse', last_name: 'Kasnicki', company: "Learning List, Inc.", email: "jessek@learninglist.com", contact_number: 5128522133, fax: 5124828658, position: 'Subscriber Liaison')


    # puts "Contact:"
    # puts contact.inspect

    # puts "Creating Contact Address..."
    # address = contact.build_address(street: "406 E. 11th St.", unit: "305", city: "Austin", state: "TX", zip: "78701")
    # address.save

    # puts "Address:"
    # puts address.inspect

    # puts "Creating Contact..."
    # contact2 = Contact.create!(first_name: 'Ed', last_name: 'Valdez', company: "Learning List, Inc.", email: "edv@learninglist.com", contact_number: 5128522131, fax: 5124828658, position: 'Vice President Marketing/Strategy')


    # puts "Contact:"
    # puts contact2.inspect

    # puts "Creating Contact Address..."
    # address2 = contact2.build_address(street: "406 E. 11th St.", unit: "305", city: "Austin", state: "TX", zip: "78701")
    # address2.save

    # puts "Address:"
    # puts address2.inspect

    puts "Creating Contact..."
    contact3 = Contact.create!(first_name: 'Christopher', last_name: 'Lucas', company: "Learning List, Inc.", email: "christopherl@learninglist.com", contact_number: 5128522131, fax: 5124828658, position: 'Director of Publisher Relations')


    puts "Contact:"
    puts contact3.inspect

    puts "Creating Contact Address..."
    address3 = contact3.build_address(street: "406 E. 11th St.", unit: "305", city: "Austin", state: "TX", zip: "78701")
    address3.save

    puts "Address:"
    puts address3.inspect

    # puts "Creating Contact..."
    # contact4 = Contact.create!(first_name: 'Jackie', last_name: 'Lain', company: "Learning List, Inc.", email: "jackiel@learninglist.com", contact_number: 5128522131, fax: 5124828658, position: 'President')


    # puts "Contact:"
    # puts contact4.inspect

    # puts "Creating Contact Address..."
    # address4 = contact4.build_address(street: "406 E. 11th St.", unit: "305", city: "Austin", state: "TX", zip: "78701")
    # address4.save

    # puts "Address:"
    # puts address4.inspect

    puts "Creating Contact..."
    contact5 = Contact.create!(first_name: 'Tasha', last_name: 'Barker', company: "Learning List, Inc.", email: "tashab@learninglist.com", contact_number: 5128522131, fax: 5124828658, position: 'Director of Alignment')

    puts "Contact:"
    puts contact5.inspect

    puts "Creating Contact Address..."
    address5 = contact5.build_address(street: "406 E. 11th St.", unit: "305", city: "Austin", state: "TX", zip: "78701")
    address5.save

    puts "Address:"
    puts address5.inspect

    publisher = Contact.where(position: 'Director of Publisher Relations').first
    publisher.update_attributes(first_name: "Chelsea", last_name: "Twohig", email: "chelseat@learninglist.com", position: "Publisher Liaison")

    puts "Creating Contact..."
    contact3 = Contact.create!(first_name: 'Catherine', last_name: 'Maloney', company: "Learning List, Inc.", email: "catherinem@learninglist.com", contact_number: 5128522133, fax: 5124828658, position: 'Director of Editorial Review')


    puts "Contact:"
    puts contact3.inspect

    puts "Creating Contact Address..."
    address3 = contact3.build_address(street: "406 E. 11th St.", unit: "305", city: "Austin", state: "TX", zip: "78701")
    address3.save

    puts "Address:"
    puts address3.inspect

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end