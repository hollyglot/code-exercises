require_relative '../sketches_init'

main_title 'Compare Params'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    @user_criteria = {"2"=>{"products"=>{"2"=>"Great for fieldtrips", "1"=>"Lab testing"}, "header"=>"Uses"}, "1"=>{"products"=>{"3"=>"OK", "2"=>"No"}, "header"=>"User Friendly"}}

    puts @user_criteria.inspect
    headers = []
    criteria_count = @user_criteria.length
    count = 1
    while count <= criteria_count
      headers << [@user_criteria[count.to_s]["header"], 30]
      count += 1
    end

    criteria = [[], [], []]
    criteria_count = @user_criteria.length
    count = 1
    while count <= criteria_count
      criteria[0] << @user_criteria[count.to_s]["products"]["1"] ? @user_criteria[count.to_s]["products"]["1"] : ""
      criteria[1] << @user_criteria[count.to_s]["products"]["2"] ? @user_criteria[count.to_s]["products"]["2"] : ""
      criteria[2] << @user_criteria[count.to_s]["products"]["3"] ? @user_criteria[count.to_s]["products"]["3"] : ""
      count += 1
    end

    products = [1, 2, 3]
    products.each_with_index do |product, i|
      puts ["Brown", "what", *criteria[i], "yep"].inspect
    end

    columns = [
      ["Products", 30],
      ["Description", 40],
      ["Grade", 20],
      ["Subject", 10],
      ["State Adopted", 15],
      ["Format", 20],
      ["Unit Price", 20],
      ["Student Groups Served", 30],
      ["Product Strengths", 40],
      ["Good to Knows", 40],
      ["Alignment Report", 20],
      ["Who's Using This Product?", 30],
      ["Average Educator Ratings", 30],
      ["Technology Requirements", 30],
      ["Publisher Questionnaire", 40],
      *headers,
      ["Comments", 30]
    ]

    puts columns.inspect
  end
end