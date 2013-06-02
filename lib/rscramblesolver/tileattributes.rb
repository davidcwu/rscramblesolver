module Rscramblesolver
  class TileAttributes
    attr_reader :letter, :points, :multiplier

    def initialize(args = {})
      @letter     = args[:letter].upcase
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
end
