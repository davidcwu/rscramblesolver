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
end