require_relative '../sketches_init'

sketch_title 'Get Alignment Report Children'

log = Telemetry::MongoidLog
log.clear!

def get_report(id)
  AlignmentReport.find id
end

def get_root_elements(report)
  template = report.alignment_template
  template.elements.roots.asc(:position).to_a
end

def print(element)
  info "#{(element.label || '').ljust(10)} #{element.content[0..100]}"
end


t = Benchmark.measure do
  id = '530290ab5cd3eb1530000002'

  report = get_report id
  root_elements = get_root_elements report

  breakouts_per_page   = []
  all_breakouts = []
  per_page = 30

  root_elements.each do |root_el|
    breakouts_per_page << report.breakouts.where(:element_id.in => root_el.subtree_ids)

    if breakouts_per_page.flatten.count >= per_page
      all_breakouts << breakouts_per_page.flatten
      breakouts_per_page = []
    end
  end

  all_breakouts << breakouts_per_page.flatten if breakouts_per_page.any?
  all_breakouts.flatten!

  all_breakouts.each do |b|
    element = b.element
    print element
    element.ancestors + [self] + ([''] * (element.alignment_template.max_depth - element.depth))
  end
end

log.output!

comment "Time #{t}"
