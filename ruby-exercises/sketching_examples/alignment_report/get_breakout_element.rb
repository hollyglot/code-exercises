require_relative '../sketches_init'

main_title 'Get Alignment Report Subtrees'

log = Telemetry::MongoidLog
log.clear!


def get_template(id)
  AlignmentTemplate.find id
end

def template_root_elements(id)
  template = get_template(id)
  template.elements.roots.asc(:position).to_a
end

def print(element)
  info "#{element.id} #{(element.label || '').ljust(10)} #{element.content[0..100]}"
end

def traverse(tree)
  tree.each do |node, children|
    print node
    traverse children
  end
end

t = Benchmark.measure do

  ar = AlignmentReport.find '51ef1925f983f58e740001db'
  breakouts = ar.breakouts

  root_elements.each do |root|
    subtree = root.subtree.arrange(order: :position)
    traverse subtree
  end

  # @graph.each do |row|
  #   puts row
  # end

  puts @graph.inspect

end

# sp.map! { |x| x == 'Limited English proficiency' ? lep_update : x }

log.output!

comment "Time #{t}"
