require 'spec_helper'

include Rscramblesolver

describe BoardCreator do
  describe :create_board do

    it 'should create tiles given the right input' do
      @boardcreator = BoardCreator.new(
          width: 2,
          height: 2
        )

      # suppress output
      @boardcreator.stub(:puts) do 
        "nothing"
      end

      input1 = "D 1 1"
      input2 = "A 2 2"
      input3 = "V 3 3"
      input4 = "E 4 4"
      @boardcreator.stub(:gets).and_return(input1, input2, input3, input4)

      board = @boardcreator.create_board

      tile_hash = board.tile_hash
      tile_hash.size.should == 4

      tileattribute_strings = tile_hash.values.map { |tile| tile.tileattributes.to_s }

      [input1, input2, input3, input4].each do |input|
        tileattribute_strings.should include(input)
      end

    end

    private

  end
end