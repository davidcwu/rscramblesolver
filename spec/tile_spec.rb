require 'spec_helper'

include Rscramblesolver

describe Tile do
  describe 'messages' do
    before(:each) do 
      @tileattributes = mock(TileAttributes)
      @tile = Tile.new(
        tileattribute: mock(@tileattributes)
        )
    end

    subject { @tile }

    it { should respond_to(:visit) }
    it { should respond_to(:unvisit) }

  end

  describe 'initialize' do 
    it 'should take a tileattribute in its hash arguments' do 
      @tileattributes = mock(TileAttributes)
      @tile = Tile.new(
          tileattributes: @tileattributes
        )

      @tile.tileattributes.should == @tileattributes
    end

    describe 'visited' do 

      it "can take 'visited' in its hash arguments" do 
        Tile.new(
            visited: true
          )
      end

      it "should respond to 'visited' with the 'visited' argument passed in" do
        @visited = true
        @tile = Tile.new(
            visited: @visited
          )
        @tile.visited.should == @visited
      end

      it "should have a default value of false" do
        @tile = Tile.new(
            {}
          )
        @tile.visited.should be_false
      end

    end
  end

  describe 'visit' do
    before(:each) do
      @tile = Tile.new
    end

    it "should return itself" do 
      @tile.visit.should == @tile
    end

    it "should set 'visited' to true" do
      @tile.visit.visited.should be_true
    end
  end

  describe 'unvisit' do
    before(:each) do
      @tile = Tile.new
    end

    it "should return itself" do 
      @tile.unvisit.should == @tile
    end

    it "should set 'visited' to false" do
      @tile.unvisit.visited.should be_false
    end
  end
end