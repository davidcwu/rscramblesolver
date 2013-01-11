require 'spec_helper'

include Rscramblesolver

describe Board do

	before(:each) do
		@board = Board.new(
			tiles: []
		)
	end

	describe :each_tile do 

		it 'should respond to each_tile' do
			@board.should respond_to(:each_tile)
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
	end

end