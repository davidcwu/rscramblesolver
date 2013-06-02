module Rscramblesolver
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

    def score
      total_multipliers * total_points
    end

    def to_s
      self.to_word
    end

    private
      def total_multipliers
        contents.inject(1) { |multiplier, tile| multiplier *= tile.multiplier }
      end

      def total_points
        contents.inject(0) { |sum, tile| sum += tile.points }
      end
  end
end
