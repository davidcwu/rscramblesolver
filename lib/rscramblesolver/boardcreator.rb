module Rscramblesolver

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

      return Board.new(tile_hash: tile_hash)
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
end
