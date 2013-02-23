module Rscramblesolver
  class Trie
    attr_reader :root

    def initialize()
      @root = TrieNode.new
    end

    # TODO: find a way to make this more elegant
    def add(item)
      item.each_char.inject(root) do |node, letter|
        next_node = node.child(letter)

        unless next_node
          node.add_child(letter)
        end
      end

      return self
    end

    # TODO: find a way to make this more elegant
    def valid_prefix?(item)
      item.each_char.inject(root) do |node, letter|
        # DEFECT: where next_node.value = letter
        next_node = node.child(letter)

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
  class TrieNode
    attr_reader :children, :value

    def initialize(args = {})
      @children = args[:children] || {}
      @value     = args[:value]     || nil
    end

    def child(letter)
      return children[letter.downcase]
    end

    def add_child(letter)
      node = child(letter) ||  TrieNode.new( :value => letter.downcase )
      children[letter] = node

      return node
    end
  end
end
