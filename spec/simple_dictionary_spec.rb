require 'spec_helper'

require 'rscramblesolver/dictionary/simple_dictionary'
require 'rscramblesolver/dictionary/word_reader'

include Rscramblesolver::Dictionary

describe SimpleDictionary do

  describe :real_word? do
    before(:each) do 
      @word_list = ['david', 'wu']
      @dictionary = SimpleDictionary.new
      @dictionary.stub(:word_list).and_return(@word_list)
    end

    it 'should return true for words inside word_list' do 
      @dictionary.real_word?('david').should be_true
    end

    it 'should return false for words outside word_list' do 
      @dictionary.real_word?('davidwu').should be_false
    end
  end


  # TODO: this will need to get pulled out into some common module for dictionaries
  describe "messages" do

    before(:each) do 
      @simple_dictionary = SimpleDictionary.new(
          word_reader: stub_word_reader
        )
    end

    subject { @simple_dictionary }

    it { should respond_to(:word_list) }
    it { should respond_to(:prefix_for_real_word?) }
    it { should respond_to(:real_word?) }

    private
      def stub_word_reader
        stub_word_list = ['david', 'wu']
        word_reader = WordReader.new
        word_reader.stub(:word_list).and_return(stub_word_list)
        return word_reader      
      end
  end


end