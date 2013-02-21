module Rscramblesolver
  class Trie
    attr_reader :root

    def initialize()
      @root = TrieBaseNode.new
    end

    # TODO: find a way to make this more elegant
    def add(item)
      item.each_char.inject(root) do |node, component|
        next_node = node.children[component]

        unless next_node
          node.children[component] = TrieNode.new(
              :value => component,
            )
        end

      end

      return self
    end

    # TODO: find a way to make this more elegant
    def valid_prefix?(item)
      item.each_char.inject(root) do |node, component|
        next_node = node.children[component]

        if next_node
          node = next_node
        else
          return false
        end
      end

      return true
    end
  end

  # Consider pulling these classes out into a separate class
  class TrieBaseNode
    attr_reader :children

    def initialize(args = {})
      @children = args[:children] || {}
    end

    # Kind of hacky
    def root?
      @value.nil?
    end
  end

  # Use inheritance sparingly
  class TrieNode < TrieBaseNode
    attr_reader :value

    def initialize(args = {})
      super(args)
      @value = args[:value]
    end

  end

end
