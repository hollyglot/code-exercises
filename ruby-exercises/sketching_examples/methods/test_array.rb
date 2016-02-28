require_relative '../sketches_init'

main_title 'Check Promo'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bmbm do |x|
  x.report do

    ar = AlignmentReport.find '523da7e3f983f570250002fc'
    breakouts = ar.breakouts.to_a
    breakouts2 = ar.breakouts.to_a
    dups = []
    breakouts.each do |br|
      dups << [br.id, br.updated_at, br.element_id]
    end

    dups.sort! { |a,b| a <=> b}

    dups.each do |d|
      puts d.inspect
    end


  end
end

log.output!
