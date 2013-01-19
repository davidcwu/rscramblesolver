require 'spec_helper'

include Rscramblesolver

describe TileContainer do
  describe 'initialize' do
    it 'should be able to take 0 arguments' do
      TileContainer.new
    end

    it 'should be able to take 1 argument' do 
      TileContainer.new([])
    end
  end

  describe 'contents' do 
    it 'should respond to contents' do 
      TileContainer.new.should respond_to(:contents)
    end
  end

  describe 'add' do
    let (:tilecontainer) { TileContainer.new }

    it 'should return another instance of TileContainer' do 
      new_tilecontainer = tilecontainer.add('hi')
      new_tilecontainer.should_not == tilecontainer
    end

    it 'should increase the size of contents by 1' do
      new_tilecontainer = tilecontainer.add('hi')
      new_tilecontainer.contents.size.should == tilecontainer.contents.size + 1
    end
  end

  describe :score do
    it 'should respond to score' do
      TileContainer.new.should respond_to(:score)      
    end

    it 'should calculate score correctly' do
      a_tile = create_tile('A', 1, 1)
      r_tile = create_tile('R', 2, 3)
      t_tile = create_tile('T', 1, 2)

      tilecontainer = TileContainer.new([a_tile, r_tile, t_tile])

      tilecontainer.score.should == 24
    end

  end

  describe :to_word do
    it 'should respond to to_word' do
      TileContainer.new.should respond_to(:to_word)
    end

    it 'should return the right word' do
      a_tile = create_tile('A', 1, 1)
      r_tile = create_tile('R', 2, 3)
      t_tile = create_tile('T', 1, 2)

      tilecontainer = TileContainer.new([a_tile, r_tile, t_tile])

      tilecontainer.to_word.should == 'ART'
    end

  end

  def create_tile(letter, points, multiplier)
    return Tile.new(
        tileattributes: TileAttributes.new(
            letter: letter,
            points: points,
            multiplier: multiplier
          )
      )
  end

end