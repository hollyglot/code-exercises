require_relative '../script_init'

main_title 'Update Form Values'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Updating Form Values..."
    sp = FormValue.update(model_name: "Component", attribute_name: "special_populations", values_list: ['Response to Intervention', 'E.L.L./L.E.P.', 'Students with Disabilities', 'Gifted and Talented', 'Credit Recovery'])

    # language = FormValue.update(model_name: "Component", attribute_name: "language", values_list: ['English only', 'Spanish only',' English and Spanish'])

    values = ['All Grade Levels', 'Pre-K', 'K', 'Elementary', '1', '2', '3', '4', '5', 'Middle School', '6', '7', '8', 'High School']
    grade = FormValue.where(model_name: "Component", attribute_name: "grade").first
    grade.values_list = values
    grade.save
    # units = FormValue.update(model_name: "Component", attribute_name: "unit_of_measure", values_list: ['per student', 'per teacher', 'per computer', 'per class', 'per campus', 'per district'])
    # open_grade = FormValue.update(model_name: "OpenSourceProduct", attribute_name: "grade", values_list: ['Pre-K', 'K', 'Elementary', '1', '2', '3', '4', '5', 'Middle School', '6', '7', '8', 'High School', 'All Grade Levels'])

    puts "Special Populations:"
    puts sp.inspect

    # puts "Language:"
    # puts language.inspect

    puts "Grade:"
    puts grade.inspect

    # puts "Units:"
    # puts units.inspect

    # puts "Open Grade:"
    # puts open_grade.inspect

    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end