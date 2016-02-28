require_relative '../script_init'

main_title 'Delete Page Subtrees'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "Getting Root Node..."
    page = Page.find 'press'

    puts "\n---------------------------------\n\n"
    puts "Getting #{page} Subtree..."
    content= page.subtree.to_a

    puts "Records: " + content.count.to_s

    puts "\n---------------------------------\n\n"
    puts "Deleting..."
    content.each do |ct|
      ct.delete
    end

    puts "\n---------------------------------\n\n"
    puts "Deleted #{page} records."
    puts "\n---------------------------------\n\n"

  end
end