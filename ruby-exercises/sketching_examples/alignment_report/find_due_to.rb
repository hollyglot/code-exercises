require_relative '../sketches_init'

main_title 'Find Due To Statement'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n-----------------------------------------\n\n"
    puts 'Getting Breakouts with Due to statment...'

    breakouts = Breakout.where(:notes => /Due to/).to_a

    puts "\n---------------------------------------\n\n"
    puts 'Number of Breakouts:'
    puts breakouts.count


    @notes = []

    breakouts.each do |breakout|
      @notes << breakout.notes
    end

    @notes.uniq!

    @notes.each do |note|
      puts "\n---------------------------------------\n\n"
      puts 'Note with Due To:'
      puts note
    end

    puts "\n---------------------------------------\n\n"
    puts 'Done!'

  end
end