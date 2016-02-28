require_relative '../script_init'

main_title 'Updating Form Values for Search'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Updating Form Value for Subject..."

    subjects = Product.published.map(&:subjects)
    subjects.flatten!
    subjects.map! {|s| s.strip}
    subjects.uniq!
    subjects.sort! { |a,b| a <=> b}
    puts subjects.inspect

    fv = FormValue.where(:model_name => "Search", :attribute_name => "subjects").first
    fv.values_list = subjects
    fv.save
    puts fv.inspect

    puts "\n---------------------------------\n\n"
    puts "Updating Form Value for Publisher..."

    publishers = Product.published.map(&:publisher_name) 
    publishers.flatten!
    publishers.map! {|p| p.strip}
    publishers.uniq!
    publishers.sort! { |a,b| a <=> b}
    puts publishers.inspect

    fv2 = FormValue.where(:model_name => "Search", :attribute_name => "publishers").first
    fv2.values_list = publishers
    fv2.save
    puts fv2.inspect
    

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end