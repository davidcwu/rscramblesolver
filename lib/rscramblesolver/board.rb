module Rscramblesolver
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
end
