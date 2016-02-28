require_relative '../script_init'

main_title 'Update Educator Rating Criteria'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do


    # ------------------------------------------------------------------------------

    puts "Updating Educator Rating Results..."
    puts "\n-------------------------------------------------------\n\n"

    # get all ratings
    ratings = Rating.all
    puts ratings.count
    # iterate through ratings
    ratings.each do |rating|
      results = rating.results
      # remove results: a from each rating
      results.delete("a")
      # move each result up a key (b->a, c->b...)
      mappings = {"b" => "a", "c" => "b", "d" => "c", "e" => "d", "f" => "e"}
      new_results = Hash[results.map {|k, v| [mappings[k], v]} ]
      # add keys f & g and set value to 0
      new_results["f"] = "0"
      new_results["g"] = "0"
      # set new results as results for rating
      rating.set(:results, new_results)
      puts rating.inspect
    end

    puts "\n-------------------------------------------------------\n\n"
    puts "Finished updating educator rating criteria."
    puts "\n-------------------------------------------------------\n\n"

  end
end