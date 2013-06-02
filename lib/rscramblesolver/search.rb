module Rscramblesolver
  class Search
    include Rscramblesolver::Dictionary
    attr_reader :board, :dictionary, :search_results

    def initialize(args = {})
      @board          = args[:board]
      @dictionary     = args[:dictionary] || SimpleDictionary.new(Hash.new)
      @search_results = SearchResults.new
    end

    def execute
      board.tile_hash.each { |coordinate, tile| execute_search_starting_on(coordinate, tile) }
      return search_results
    end

    private

      def execute_search_starting_on(coordinate, tile)
        board.visit(coordinate)

        tile_container = TileContainer.new.add(tile)
        execute_search_starting_on_helper(board, coordinate, tile, tile_container)

        board.unvisit(coordinate)
      end

      # TODO: Iterative Deepening
      # TODO: Word scores
      def execute_search_starting_on_helper(board, coordinate, tile, tilecontainer)
        word_so_far = tilecontainer.to_word

        search_results.add(tilecontainer) if dictionary.real_word?(word_so_far)

        # TODO: optimizing by pruning using prefixes here
        board.unvisited_neighbors_hash(coordinate).each do |neighbor_coordinate, neighbor|
          board.visit(neighbor_coordinate)

          new_tilecontainer = tilecontainer.add(neighbor)
          execute_search_starting_on_helper(board, neighbor_coordinate, neighbor, new_tilecontainer)

          board.unvisit(neighbor_coordinate)
        end
    end
  end
end
