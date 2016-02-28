require_relative '../script_init'

main_title 'Create Form Values'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Creating Form Value..."

    aligned_options = []
    aligned_options << ["Select Appropriate Stem", ""]
    aligned_options << ["Not addressed in publisher's correlation", "Not addressed in publisher's correlation"]
    puts aligned_options.inspect

    fv = FormValue.create!(:model_name => "Breakout", :attribute_name => "pages", :values_list => aligned_options)

    puts fv.inspect

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end