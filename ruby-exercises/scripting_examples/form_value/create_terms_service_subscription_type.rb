require_relative '../script_init'

main_title 'Create Form Values'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Creating Form Value..."

    fv = FormValue.all_of(:model_name => "TermsOfService", :attribute_name => "subscription_type").first

    if fv
      fv.delete
    end


    options = ["Individual", "Publisher", "District/Campus"]

    fv = FormValue.create!(:model_name => "TermsOfService", :attribute_name => "subscription_type", :values_list => options)

    puts fv.inspect

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end