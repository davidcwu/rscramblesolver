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

  describe 'add and then calling valid_prefix?' do
    it 'should be successful with the same word' do
      trie.add('hello').valid_prefix?('hello').should be_true
    end

    it 'should be successful with a prefixed version of the added word' do
      trie.add('ballerina').valid_prefix?('ball').should be_true
    end

    it 'should be unsuccessful with a different prefix' do
      trie.add('carpinteria').valid_prefix?('carpet').should be_false
    end
  end

end
