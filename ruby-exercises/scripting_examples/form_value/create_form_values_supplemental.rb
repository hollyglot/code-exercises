require_relative '../script_init'

main_title 'Create Form Values'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Creating Form Value..."

    fv = FormValue.all(:model_name => "Component", :attribute_name => "supplemental_replacement_text").first
    fv.delete if fv

    options = []
    options << 'This supplemental product material is designed specifically to address a select subset of standards. For that reason, the alignment % is shown only at the top of the alignment report.'
    options << 'This supplemental resource is intended to support the primary instructional materials for the course; it is not intended to be used in isolation. For that reason, the alignment % is shown only at the top of the alignment report.'
    options << 'None'

    fv = FormValue.create!(:model_name => "Component", :attribute_name => "supplemental_replacement_text", :values_list => options)

    puts fv.inspect

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end