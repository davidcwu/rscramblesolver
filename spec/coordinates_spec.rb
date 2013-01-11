require 'spec_helper'

include Rscramblesolver

describe Coordinates do
	before(:each) do
		@x, @y = 23, 52
		@coordinates = Coordinates.new(
			x: @x,
			y: @y
			)
	end

	it 'should respond to x' do
		@coordinates.should respond_to(:x)
	end

	it 'should respond to y' do
		@coordinates.should respond_to(:y)
	end

	it 'should return the correct x value' do
		@coordinates.x.should == @x
	end

	it 'should return the correct y value' do
		@coordinates.y.should == @y
	end
end