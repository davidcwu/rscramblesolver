require 'spec_helper'

include Rscramblesolver

describe Search do
  describe :initialize do 
    it 'should take board in its args hash' do 
      board = mock(Board)
      search = Search.new(
          board: board
        )
      search.board.should == board
    end
  end

  describe :execute do
    it "should execute and return the right results" do
      # Set up the board
      #     D T
      #     R A
      upleft_tile    = create_tile_with_letter('D')
      upright_tile   = create_tile_with_letter('T')
      downleft_tile  = create_tile_with_letter('R')
      downright_tile = create_tile_with_letter('A')

      upleft_coordinate    = Coordinates.new(x:0, y:0)
      upright_coordinate   = Coordinates.new(x:0, y:1)
      downleft_coordinate  = Coordinates.new(x:1, y:0)
      downright_coordinate = Coordinates.new(x:1, y:1)

      tile_hash = {
        upleft_coordinate    => upleft_tile,
        upright_coordinate   => upright_tile,
        downleft_coordinate  => downleft_tile,
        downright_coordinate => downright_tile
      }

      board = Board.new(
          tile_hash: tile_hash
        )

      # Set up a word reader
      word_list = ['DART', 'ART', 'AT']

      word_reader = mock(WordReader)
      word_reader.stub(:word_list).and_return(word_list)

      # Set up the dictionary
      dictionary = SimpleDictionary.new(
          word_reader: word_reader
        )

      # Set up the search
      search = Search.new(
          board: board,
          dictionary: dictionary
        )

      # Sort and compare the list
      search_results = search.execute
      search_results_words = search_results.results.map { |tilecontainer| tilecontainer.to_word }
      search_results_words.sort.should == word_list.sort
    end

    def create_tile_with_letter(letter)
      return Tile.new(
        tileattributes: TileAttributes.new(
            letter: letter
          )
      )
    end

  end


end