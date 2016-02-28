module Domain
  module StaticPages
    class TreeBuilder
      def self.!(parent)
        instance = new parent
        instance.!
      end

      def initialize(parent)
        @parent = parent
      end

      def !
        build
      end

      def parent
        @parent
      end

      def build
        tree_hash = parent.subtree.arrange(order: :position) # See: https://github.com/skyeagle/mongoid-ancestry#arrangement
        
        content_tree = {}
        content_tree = create_content_tree(tree_hash)
        content_tree
      end

      def create_content_tree(tree_hash)
        parent_hash = {}
        tree_hash.each do |parent, child_hash|
          parent_hash[parent.sluggable_field] = create_child_tree(child_hash)
        end
        parent_hash
      end

      def create_child_tree(child_hash)
        child_hash = {}
        child_hash.each do |key, value|
          if key == 'sluggable_field'
          child_hash[parent.sluggable_field] = create_child_tree(child_hash)
        end
        child_hash
      end

    end
  end
end