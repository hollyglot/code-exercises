require_relative './sketches_init'

main_title 'Get Alignment Report Subtrees'

log = Telemetry::MongoidLog
log.clear!

t = Benchmark.measure do

  ar = AlignmentReport.find '51ed7b1cf983f53af800061a'
  # ar = AlignmentReport.find '51a6878bf983f519b400015f'
  table = ::Domain::AlignmentReport::Builders::DatatableBuilder.! ar
  table.each do |row|
    row.each do |element|
      if element.class == Element
        puts "#{element.id} #{element.label || ''} #{element.content[0..100]}"
      else
        puts "#{element.id} #{element.element_id} #{element.editors_notes}"
      end
    end
    puts "----------------------------------------\n"
  end

end

log.output!

comment "Time #{t}"
