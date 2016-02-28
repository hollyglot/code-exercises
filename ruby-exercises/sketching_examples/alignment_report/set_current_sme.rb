require_relative '../sketches_init'

main_title 'Build Address Buttons'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bmbm do |x|
  x.report do
    ar = AlignmentReport.find '5387493ff983f5e13f000106'
    sme = ar.current_sme
    ar.set(:current_sme_name, sme.name)
    ar.set(:current_sme_id, sme.id)

    ar.finalized_at_date = ar.finalized_at.strftime("%Y/%m/%d %I:%M %p")

    smes = "<ul>"
    %w('First SME' 'Second SME' 'Third SME').each do |sme_ordinal|
      sme = alignment_report.send(sme_ordinal.to_snake_case)
      smes += "<li>#{sme_ordinal}:" + '<a href="/smes/' + sme.id + '">' + sme.name + '</a></li>' if sme
    end
    smes += "</ul>"

    alignment_report.set(:smes_list, smes)

    puts ar.inspect
  end
end

log.output!
