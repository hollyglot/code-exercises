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

def reset_rows
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
      @graph << @rows[key]
    end
    @rows = {}
  end
end

def append_breakout(element)
  @breakouts.each do |breakout|
    if breakout.element_id == element.id
      # @rows[element.position] << breakout
      @duplicate_breakouts[element.position] = [] if @duplicate_breakouts[element.position].nil?
      @duplicate_breakouts[element.position] << breakout
    end
  end
end

def traverse(tree)

  tree.each do |node, children|
    if node.depth == 0
      @parents = []
    end

    unless node.ancestry_depth > @ancestry_depth
      @parents[node.depth] = "#{(node.label || '')} #{node.content}" 
      @rows[node.position] = [] if @rows[node.position].nil?

      @rows[node.position] = @parents

      if children.empty?
        append_breakout(node)
        reset_rows
      end

      traverse children
    end
  end
end

t = Benchmark.measure do

  ar = AlignmentReport.find '51ef1925f983f58e740001db'
  @ancestry_depth = ar.alignment_template.standard.calculation_level
  at = ar.alignment_template
  root_elements = template_root_elements(at.id)
  @graph = []
  @rows = {}
  @duplicate_breakouts = {}
  @breakouts = ar.breakouts.to_a

  root_elements.each do |root|
    subtree = root.subtree.arrange(order: :position)
    traverse subtree
  end

  # @graph.uniq!
  # @graph.each do |row|
  #   puts row.inspect
  # end

  @duplicate_breakouts.each do |row|
    puts row.inspect
  end

end

log.output!

comment "Time #{t}"
