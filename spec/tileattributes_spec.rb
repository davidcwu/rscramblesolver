require 'spec_helper'

include Rscramblesolver

describe TileAttributes do
  describe :initialize do
    it 'should take in a letter in its args hash' do
      @tileattributes = TileAttributes.new(
          letter: :a
        )
      @tileattributes.letter.should == :a
    end

    it 'can take in a point value in its args hash' do
      @tileattributes = TileAttributes.new(
          points: 5
        )
      @tileattributes.points.should == 5
    end

    it 'can take in a multiplier in its args hash' do
      @tileattributes = TileAttributes.new(
          multiplier: 5
        )
      @tileattributes.multiplier.should == 5
    end      

    it 'will have a default point value of 1' do
      @tileattributes = TileAttributes.new(
          {}
        )
      @tileattributes.points.should == 1
    end

    it 'will have a default multiplier value of 1' do
      @tileattributes = TileAttributes.new(
        {}
      )
      @tileattributes.multiplier.should == 1
    end
  end

  describe :score do
    it 'should be the product of points and multiplier' do
      @tileattributes = TileAttributes.new(
          points: 5,
          multiplier: 100
        )
      @tileattributes.score.should == 500
    end
  end
end