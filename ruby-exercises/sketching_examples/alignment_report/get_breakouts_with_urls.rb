require_relative '../sketches_init'

main_title 'Get Breakouts with URLs'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do
    
    breakouts = Breakout.where(:pages => /(http|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])?/)
    
    breakouts.each do |breakout|
      puts breakout.alignment_report.title if breakout.alignment_report
      puts breakout.alignment_report.id if breakout.alignment_report
      puts breakout.pages #aligned citations
      puts breakout.significant_differences # non-aligned citations
      puts breakout.pending_message #Pending citations
      puts breakout.addressed #aligned to standard
      puts breakout.notes #reviewer's comments
      puts breakout.editors_notes # Second Reviewer's Comments
      
      puts breakout.comments #Publisher comments
      puts breakout.response # Learning List's Response to publishers
    end
  end
end
