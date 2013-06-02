module Rscramblesolver
  class Tile
    attr_reader :tileattributes, :visited

    def initialize(args = {})
      @tileattributes = args[:tileattributes]
      @visited        = args[:visited] || false
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
      tileattributes.letter
    end

    def multiplier
      tileattributes.multiplier
    end

    def points
      tileattributes.points
    end
  end
end
