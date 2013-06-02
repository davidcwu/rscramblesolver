module Rscramblesolver
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
end
