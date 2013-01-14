require 'spec_helper'

include Rscramblesolver

describe TileAttributes do
  describe :initialize do
    it 'should take in a letter in its args hash and upcase it' do
      @tileattributes = TileAttributes.new(
          letter: :a
        )
      @tileattributes.letter.should == :A
    end

    it 'can take in a point value in its args hash' do
      @tileattributes = TileAttributes.new(
          letter: :a,     
          points: 5
        )
      @tileattributes.points.should == 5
    end

    it 'can take in a multiplier in its args hash' do
      @tileattributes = TileAttributes.new(
          letter: :a,
          multiplier: 5
        )
      @tileattributes.multiplier.should == 5
    end      

    it 'will have a default point value of 1' do
      @tileattributes = TileAttributes.new(
          letter: :a
        )
      @tileattributes.points.should == 1
    end

    it 'will have a default multiplier value of 1' do
      @tileattributes = TileAttributes.new(
          letter: :a
      )
      @tileattributes.multiplier.should == 1
    end
  end

  describe :to_s do
    it 'should be in the right format' do
      @tileattributes = TileAttributes.new(
        letter: :a
      )
      @tileattributes.to_s.should == "A 1 1"
    end
  end

  describe :score do
    it 'should be the product of points and multiplier' do
      @tileattributes = TileAttributes.new(
          letter: :a,
          points: 5,
          multiplier: 100
        )
      @tileattributes.score.should == 500
    end
  end
end