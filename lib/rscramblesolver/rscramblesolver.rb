module Rscramblesolver

	class Search
		attr_reader :board, :dictionary, :search_results

		def initialize(args = {})
			@board 					= args[:board]
			@dictionary 		= args[:dictionary] || SimpleDictionary.new(Hash.new)
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

	# Handles the I/O involved in creating a board
	# I/O always feels ugly. Is there a way to make this elegant?
	class BoardCreator
		attr_reader :width, :height

		def initialize(args = {})
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
		attr_reader :tile_hash

		# Tiles_hash is a hash from coordinates => tiles
		def initialize(args = {})
			@tile_hash = args[:tile_hash] || [[]]
		end

		def add_tile(coordinates, tile)
			tile_hash[coordinates] = tile
		end

		def visit(coordinates)
			tile_hash[coordinates].visit
		end

		def unvisit(coordinates)
			tile_hash[coordinates].unvisit
		end

		def unvisited_neighbors_hash(coordinates)
			neighbors_hash(coordinates).select { |coordinate, neighbor| !neighbor.visited }
		end

		private
			def neighbors_hash(coordinates)
				neighbors = {}

				[[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].each do |step|
					neighbor_coordinate = Coordinates.new(
							x: coordinates.x + step[0],
							y: coordinates.y + step[1]
						)
					neighbors[neighbor_coordinate] = tile_hash[neighbor_coordinate] if tile_hash.has_key?(neighbor_coordinate)
				end

				return neighbors
			end

	end

	class Coordinates
		attr_reader :x
		attr_reader :y

		def initialize(args = {})
			@x = args[:x]
			@y = args[:y]
		end

		def eql?(other)
			return false unless other.respond_to?(:x) and other.respond_to?(:y)
			return x == other.x && y == other.y
		end

		def hash
			[x, y].hash
		end

		def to_s
			"x: #{x}, y: #{y}"
		end
	end

	class TileAttributes
		attr_reader :letter, :points, :multiplier

		def initialize(args = {})
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

		def initialize(args = {}) 
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

		def letter
			@tileattributes.letter
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

		def to_word
			str = ''
			contents.each { |tile| str << tile.letter }
			return str
		end

		def to_s
			self.to_word
		end
	end

	class SearchResults
		attr_reader :results

		def initialize
			@results = []
		end

		def add(result)
			results << result
		end

		def to_s
			results
		end
	end

end