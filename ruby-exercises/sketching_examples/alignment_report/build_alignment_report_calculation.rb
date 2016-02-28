require_relative '../sketches_init'

main_title 'Alignment Report Calculation'

log = Telemetry::MongoidLog
log.clear!

def traverse_children(tree, children_breakouts=nil)
  if children_breakouts.nil?
    children_breakouts = []
  end
  tree.each do |node, children|
    if children.empty?
      @breakouts.each do |breakout|
        if breakout.element_id == node.id
          children_breakouts << breakout
        end
      end
    else
     children_breakouts = traverse_children(children, children_breakouts)
    end
  end
  children_breakouts
end

def traverse(tree, ancestry_depth)
  tree.each do |node, children|
    
    if node.ancestry_depth == ancestry_depth
      children_breakouts = []
      if children.empty?
        @breakouts.each do |breakout|
          if breakout.element_id == node.id
            children_breakouts << breakout
          end
        end
      else
        children_breakouts = traverse_children(children)
      end

      # Find all breakouts that are NA
      na_children = children_breakouts.select { |breakout|  breakout.addressed == "not_applicable"}
      
      # Do not inlude parent standard in coverage calculation if all the child standards are NA
      if children_breakouts.count != na_children.count
        @calculate_elements << node

        # Standard is aligned if none of the child nodes are unsatisfied
        if children_breakouts.select { |breakout|  breakout.addressed == "unsatisfied" || breakout.addressed == "not_applicable"}.empty?
          @addressed << node
          puts node.label
        else
          puts '------------------'
          puts 'Not aligned:'
          puts node.label
        end
      end
    else
      traverse children, ancestry_depth
    end
  end
end

def calculate_coverage_percent
  # get depth of parent node on which alignment is calculated 
  # all child nodes of the parent must be aligned for parent standard to be aligned
  depth_of_alignment_calculation_node = @alignment_report.alignment_template.standard.calculation_level

  root_elements = @alignment_template.elements.roots.asc(:position).to_a
  root_elements.each do |root|
    subtree = root.subtree.arrange(order: :position)
    traverse subtree, depth_of_alignment_calculation_node
  end
  if @calculate_elements.count > 0
    percent = (@addressed.count.to_f * 100 / @calculate_elements.count)
  else
    percent = 0
  end
  percent
end


Benchmark.bm do |x|
  x.report do

    @alignment_report = AlignmentReport.find "51f2c002f983f5a75900120d"
    @alignment_template = ::AlignmentTemplate.where(:id => @alignment_report.alignment_template_id).first
    @breakouts = @alignment_report.breakouts

    @addressed = []
    @calculate_elements = []
    
    percent = calculate_coverage_percent

    puts @addressed.count
    puts @calculate_elements.count
    puts percent
  end
end

log.output!