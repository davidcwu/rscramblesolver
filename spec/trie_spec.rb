require 'spec_helper'

include Rscramblesolver

describe Trie do

  let(:trie) { Trie.new }

  describe :initialize do
    it 'should be initialized correctly' do
      # Handled by the let()
    end
  end

  describe :add do
    it 'should respond to add' do
      trie.should respond_to(:add)
    end
  end

  describe :valid_prefix? do
    it 'should respond_to valid_prefix?' do
      trie.should respond_to(:valid_prefix?)
    end
  end
end
