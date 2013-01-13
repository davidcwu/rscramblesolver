module Rscramblesolver

	class Search
		attr_reader :board, :dictionary, :search_results

		def initialize(args)
			@board 					= args[:board]
			@dictionary 		= args[:dictionary] || SimpleDictionary.new
			@search_results = args[:results_container] || SearchResults.new
		end

		def execute
			board.each_tile { |tile| execute_search_starting_on(tile) }
			return search_results
		end

		private

			def execute_search_starting_on(tile)
				execute_search_starting_on_helper(board, tile, TileContainer.new)
			end

			def execute_search_starting_on_helper(board, tile, tilecontainer)
				word_so_far = tilecontainer.to_word

				search_results.add(tilecontainer) if dictionary.real_word?(word_so_far)

				# TODO: optimizing by pruning using prefixes here

				board.unvisited_neighbors(tile).each do |neighbor|
					board.visit(neighbor)

					new_tilecontainer = tilecontainer.add(neighbor)
					execute_search_starting_on_helper(board, neighbor, new_tilecontainer)

					board.unvisit(neighbor)
				end
					
			end
	end

	class Board

		def initialize(args)
			@tiles = args[:tiles]
		end

		def each_tile
			@tiles.each
		end

		def visit(tile)
			tile.visit
		end

		def unvisit(tile)
			tile.unvisit
		end

		def unvisited_neighbors(tile)
		end

		private
			def neighbors(tile)

			end

			def coordinates(tile)

			end
	end

	class Coordinates
		attr_reader :x
		attr_reader :y

		def initialize(args)
			@x = args[:x]
			@y = args[:y]
		end
	end

	class TileAttributes
	end

	class Tile
		attr_reader :tileattributes, :visited

		def initialize(args) 
			@tileattributes = args[:tileattributes]
			@visited       = args[:visited] || false
		end

		def visit
			@visited = true
			return self
		end

		def unvisit
			@visited = false
			return self
		end
	end

	# TODO: I could probably change this name to something more generic like an immutablelist
	class TileContainer
	  attr_reader :contents

		def initialize(contents = [])
			@contents = contents
		end
			
		def add(tile)
			new_contents = contents.clone << tile
			return TileContainer.new(new_contents)
		end
	end

	class SearchResults
		attr_reader :results

		def initialize
			self.results = []
		end

		def add(result)
			results << result
		end

		def to_s
			puts results
		end
	end

end