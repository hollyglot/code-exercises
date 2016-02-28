require_relative '../sketches_init'

main_title 'Get Alignment Report Subtrees'

log = Telemetry::MongoidLog
log.clear!

def print(element)
  info "#{element.id} #{(element.label || '').ljust(10)} #{element.content[0..100]}"
end

def append_rows
  unless @rows.empty?
    @rows.each do |k, v|
      ary = []
      v.each_with_index do |element, index|
        if element.nil?
          ary[index] = @rows[0][index]
        else
          ary[index] = element
        end
      end

      @rows[k] = ary
    end

    keys = @rows.keys.sort
    keys.each do |key|
      @table.append @rows[key]
    end
    @rows = {}
  end
end

def append_breakout(element)
  @breakouts.each do |breakout|
    if breakout.element_id == element.id
      @rows[element.position] << breakout
    end
  end
end

def traverse(tree)

  tree.each do |node, children|
    if node.depth == 0
      @parents = []
    end

    # Remove any trailing children from the previous sibling tree
    par_sum = @parents.length
    @parents.slice!(node.depth..par_sum)

    # Insert the node into the parent hash
    @parents[node.depth] = node
    @rows[node.position] = [] if @rows[node.position].nil?

    # Insert the parents into the correct row by node position
    parents = @parents
    @rows[node.position] = parents

    if children.empty?
      append_breakout(node)
      append_rows

      # Clear out previous sibling and its children from the parent hash
      p_sum = @parents.length
      @parents.slice!(node.depth..p_sum)
    end

    traverse children
  end
end

t = Benchmark.measure do

  ar = AlignmentReport.find '555e508dfbc892e51d000044'
  @alignment_template = ::AlignmentTemplate.where(:id => ar.alignment_template_id).first
  root_elements = @alignment_template.elements.roots.asc(:position).to_a
  @table = []
  @rows = {}
  @breakouts = ar.breakouts.to_a



  root_elements.each do |root|
    subtree = root.subtree.arrange(order: :position)
    traverse subtree
  end

  @table.uniq!
  @table.each do |row|
    puts "\n"
    row.each do |element|
      print element unless element.class.to_s == "Breakout"
    end
  end

end

log.output!

comment "Time #{t}"
