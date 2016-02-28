require_relative '../script_init'

main_title 'Create Form Values for Search'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    # puts "\n---------------------------------\n\n"
    # puts "Creating Form Value for Material Format..."

    # mf = ["Print","Online","Print and/or Online","Online Interactive Course, (e.g. with live teacher)","Other Digital Media, (e.g. USB or CD-ROM)","Other Physical Media, (e.g. DVD)"]

    # fv = FormValue.create!(:model_name => "Search", :attribute_name => "material_format", :values_list => mf)
    # puts fv.inspect


    # puts "\n---------------------------------\n\n"
    # puts "Creating Form Value for Material Types..."

    # options = ["Comprehensive", "Supplemental"]
    # mt = FormValue.create!(:model_name => "Search", :attribute_name => "material_type", :values_list => options)
    # puts mt.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Form Values for Standard Search Dropdown..."

    options = ["CCSS", "TEKS"]
    mt = FormValue.create!(:model_name => "Search", :attribute_name => "standard", :values_list => options)
    puts mt.inspect

    # puts "\n---------------------------------\n\n"
    # puts "Creating Form Value for Subject..."

    # subjects = Product.published.map(&:subjects)
    # subjects.flatten!
    # subjects.uniq!
    # subjects.sort! { |a,b| a <=> b}
    # puts subjects.inspect

    # fv = FormValue.create!(:model_name => "Search", :attribute_name => "subjects", :values_list => subjects)
    # puts fv.inspect


    # puts "\n---------------------------------\n\n"
    # puts "Creating Form Value for Publisher..."

    # publishers = Product.published.map(&:publisher_name).sort
    # publishers.flatten!
    # publishers.uniq!
    # publishers.sort! { |a,b| a <=> b}
    # puts publishers.inspect

    # fv = FormValue.create!(:model_name => "Search", :attribute_name => "publishers", :values_list => publishers)
    # puts fv.inspect
    

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end