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

	describe 'equality' do 

		it 'should be == to another object with the same x and y value' do
			@same_coordinates = Coordinates.new(
					x: @x,
					y: @y
				)
			@coordinates.should == @same_coordinates
		end

		it 'should not be == to another object with different x and y value' do 
			@same_coordinates = Coordinates.new(
					x: @x + 1,
					y: @y
				)
			@coordinates.should_not == @same_coordinates
		end
	end
end