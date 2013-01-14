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

	# Handles the I/O involved in creating a board
	# I/O always feels ugly. Is there a way to make this elegant?
	class BoardCreator
		attr_reader :width, :height

		def initialize(args)
			@width  = args[:width]  || 4
			@height = args[:height] || 4
		end

		def create_board
			puts "Enter letter, points, and multiplier separated by spaces"
			puts "ie) W 2 3"

			0.upto(width - 1) do |width_index|
				0.upto(height - 1) do |height_index|
					puts "Width: #{width_index}, Height: #{height_index}"

					coordinate = Coordinates.new(
							x: width_index, 
							y: height_index
						)
					tile = create_tile_from_user_input
					tile_hash[coordinate] = tile

				end
			end

			return Board.new(
					tile_hash: tile_hash
				)
		end

		private

			def tile_hash
				@tile_hash ||= Hash.new
			end

			def create_tile_from_user_input
				letter, points, multiplier = gets.split
				return Tile.new(
						tileattributes: TileAttributes.new(
								letter: letter,
								points: points.to_i,
								multiplier: multiplier.to_i
							)
					)
			end
	end

	class Board

		# Tiles is a hash from coordinates => tiles
		def initialize(args)
			@tile_hash = args[:tile_hash]
		end

		def add_tile(coordinates, tile)
			@tile_hash[coordinates] = tile
		end

		def each_tile_with_coordinate
			@tile_hash.each { |key, value| yield(value, key) }
		end

		def visit(coordinates)
			@tile_hash[coordinates].visit
		end

		def unvisit(coordinates)
			@tile_hash[coordinates].unvisit
		end

		def unvisited_neighbors(coordinates)
			neighbors(coordinates).select { |neighbor| !neighbor.visited }
		end

		private
			def neighbors(coordinates)
				neighbors = []

				[[-1, -1], [-1, 0], [1, 0], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].each do |step|
					neighbor_coordinate = Coordinates.new(
							x: coordinates.x + step[0],
							y: coordinates.y + step[1]
						)
					neighbors << @tile_hash[neighbor_coordinate] if @tile_hash.has_key?(neighbor_coordinate)
				end

				return neighbors
			end

	end

	class Coordinates
		attr_reader :x
		attr_reader :y

		def initialize(args)
			@x = args[:x]
			@y = args[:y]
		end

		def ==(other)
			return false unless other.respond_to?(:x) and other.respond_to?(:y)
			return x == other.x && y == other.y
		end
	end

	class TileAttributes
		attr_reader :letter, :points, :multiplier

		def initialize(args)
			@letter 		= args[:letter].upcase
			@points     = args[:points]     || 1
			@multiplier = args[:multiplier] || 1
		end

		def score
			points * multiplier
		end

		def to_s
			"#{letter} #{points} #{multiplier}"
		end
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