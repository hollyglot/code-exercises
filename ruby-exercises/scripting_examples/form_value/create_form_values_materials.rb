require_relative '../script_init'

main_title 'Create Form Values for Material Formats and Types'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Creating Form Value for Material Formats..."

    options = ["Print", "Online", "Online Interactive Course, (e.g. with live teacher)", "Digital, (e.g. USB or CD-ROM)", "Other Physical Media, (e.g. DVD)"]

    fv = FormValue.create!(:model_name => "Component", :attribute_name => "material_format", :values_list => options)
    puts fv.inspect

    puts "\n---------------------------------\n\n"
    puts "Creating Form Value for Material Types..."

    options = ["Comprehensive", "Supplemental", "Assessments", "Test Prep", "Professional Development"]
    fv = FormValue.create!(:model_name => "Component", :attribute_name => "material_type", :values_list => options)
    puts fv.inspect

 
  end
end