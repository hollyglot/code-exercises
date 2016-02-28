require_relative '../script_init'

main_title 'Create Form Values'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    fv_orig = FormValue.all_of(:model_name => "Breakout", :attribute_name => "ccss-math-stems").first
    if fv_orig
      fv_orig.delete
    end

    puts "\n---------------------------------\n\n"
    puts "Creating Form Value..."

    stem_options = []
    stem_options << ["Select Appropriate Stem", ""]
    stem_options << ["This standard is not cited for this course in Appendix A of the Common Core Standards for Mathematics. For that...", "This standard is not cited for this course in Appendix A of the Common Core Standards for Mathematics. For that reason, Learning List did not include this standard in the calculation of the alignment percentage for this course."]
    puts stem_options.inspect

    fv = FormValue.create!(:model_name => "Breakout", :attribute_name => "ccss-math-stems", :values_list => stem_options)

    puts fv.inspect

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end