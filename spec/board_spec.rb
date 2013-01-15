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

    it 'should return unvisited neighbors' do 

      main_tile      = mock(Tile)
      right_tile     = mock(Tile)
      down_tile      = mock(Tile)
      downright_tile = mock(Tile)

      right_tile.stub(:visited).and_return(true)
      down_tile.stub(:visited).and_return(false)
      downright_tile.stub(:visited).and_return(false)

      main_coordinates = Coordinates.new(x:0, y:0)
      tile_hash = {
        main_coordinates => main_tile,
        Coordinates.new(x:0, y:1) => right_tile,
        Coordinates.new(x:1, y:0) => down_tile,
        Coordinates.new(x:1, y:1) => downright_tile
      }

      @board.stub(:tile_hash).and_return(tile_hash)

      unvisited_neighbors = @board.unvisited_neighbors(main_coordinates)

      unvisited_neighbors.should include(down_tile)
      unvisited_neighbors.should include(downright_tile)
    end

	end

end