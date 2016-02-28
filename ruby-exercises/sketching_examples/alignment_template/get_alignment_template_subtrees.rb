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

  id = '52405454f983f571c1000d85'
  root_elements = template_root_elements(id)

  root_elements.each do |root|
    subtree = root.subtree.arrange(order: :position)
    traverse subtree
  end
end

log.output!

comment "Time #{t}"
