require_relative '../sketches_init'

main_title 'Get Alignment Report Table'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do
	  ar = AlignmentReport.find '555e508dfbc892e51d000044'
	  table = Domain::AlignmentReport::Builders::DatatableBuilder.! ar
	  
    p = "##" * 50
    puts p

    table.each do |row|
      l = "--" * 30
      puts l
      row.each do |element|
        if element.class.to_s == "Element"
          puts "#{(element.label || '').ljust(10)} #{element.content[0..100]}"
        else
          puts element.addressed
        end
      end
    end

	end
end

log.output!