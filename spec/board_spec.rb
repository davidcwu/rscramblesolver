require 'spec_helper'

include Rscramblesolver

describe Board do

	before(:each) do
		@board = Board.new(
			tiles: [[]]
		)
	end

	describe :each_tile do 

		it 'should respond to each_tile_with_coordinate' do
			@board.should respond_to(:each_tile_with_coordinate)
		end
	end

	describe :visit do
		it 'should respond to visit' do
			@board.should respond_to(:visit).with(1).argument
		end
	end

	describe :unvisited_neighbors do
		it 'should respond to unvisited_neighbors' do
			@board.should respond_to(:unvisited_neighbors).with(1).argument
		end

    # This test feels weird. I need to look up more rspec/stubbing techniques
    it 'should return unvisited neighbors' do 
      @main_tile = mock(Tile)
      @tile1 = mock(Tile)
      @tile2 = mock(Tile)

      @tile1.stub(:visited).and_return(true)
      @tile2.stub(:visited).and_return(false)

      @board.stub(:neighbors).and_return([@tile1, @tile2])

      @board.unvisited_neighbors(@main_tile).size.should == 1
    end
	end

end