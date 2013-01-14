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

	describe 'eql?' do 

		it 'should be eql to another object with the same x and y value' do
			@same_coordinates = Coordinates.new(
					x: @x,
					y: @y
				)
			@coordinates.should eql(@same_coordinates)
		end

		it 'should not be == to another object with different x and y value' do 
			@same_coordinates = Coordinates.new(
					x: @x + 1,
					y: @y
				)
			@coordinates.should_not eql(@same_coordinates)
		end
	end

	describe 'hash' do 
				it 'should have a hash equal to another object with the same x and y value' do
			@same_coordinates = Coordinates.new(
					x: @x,
					y: @y
				)
			@coordinates.hash.should == @same_coordinates.hash
		end

		it 'should not be == to another object with different x and y value' do 
			@same_coordinates = Coordinates.new(
					x: @x + 1,
					y: @y
				)
			@coordinates.hash.should_not == @same_coordinates.hash
		end
	end
end