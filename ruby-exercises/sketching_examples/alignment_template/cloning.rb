require_relative '../sketches_init'

main_title 'Clone Alignment Template'

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

def update_parent_ids(node, children)

  if node.ancestry_depth == 0
    @parents = []
  end

  # Remove any trailing children from the previous sibling tree
  par_sum = @parents.length
  @parents.slice!(node.depth..par_sum)

  parents_ids = ""
  @parents.each do |id|
    parents_ids += "#{id}/"
  end

  # Remove trailing backslash
  node.ancestry = parents_ids[0..-2] unless node.ancestry_depth == 0

  puts "New Element"
  puts node.inspect
  node.save

  # Insert the node id into the parents array
  @parents[node.ancestry_depth] = node.id

  if children.empty?
    # Clear out previous sibling and its children from the parent hash
    p_sum = @parents.length
    @parents.slice!(node.depth..p_sum)
  end
end

def clone_element(element, children)
  new_element = Element.new
  new_element = element.clone
  new_element.alignment_template_id = @new_at.id
  new_element.created_at = Time.now()
  new_element.updated_at = Time.now()
  new_element.save

  saved_element = Element.find new_element.id
  update_parent_ids(saved_element, children)
end

def traverse(tree)
  tree.each do |node, children|
    print node
    clone_element(node, children)
    traverse children
  end
end

t = Benchmark.measure do

  id = '51a9208df983f55edb001b1e'
  root_elements = template_root_elements(id)

  old_at = AlignmentTemplate.find id

  at = old_at.attributes
  at.delete("standard")
  at.delete("standard_name")
  at.delete("flag")

  new_at = AlignmentTemplate.new
  new_at.assign_attributes(at)
  new_at.created_at = Time.now()
  new_at.updated_at = Time.now()
  new_at.save

  @new_at = AlignmentTemplate.last

  root_elements.each do |root|
    subtree = root.subtree.arrange(order: :position)
    traverse subtree
  end
end

# log.output!

comment "Time #{t}"
