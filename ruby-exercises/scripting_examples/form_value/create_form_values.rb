require_relative '../script_init'

main_title 'Create Form Values'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Creating Form Value..."

    options = ["annual", "trial"]

    fv = FormValue.create!(:model_name => "Subscription", :attribute_name => "type", :values_list => options)

    puts fv.inspect

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end