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

describe TrieNode do
  describe 'messages to respond to' do
    subject { TrieNode.new }

    it { should respond_to(:child) }
    it { should respond_to(:add_child) }
  end

  describe :child do
    it 'should return nil if there is no child' do
      node = TrieNode.new
      node.child('a').should be_nil
    end

    it 'should return a child if a child exists' do
      letter = 'a'
      child_node = TrieNode.new
      children = { letter => child_node }
      node = TrieNode.new( :children => children )

      node.child(letter).should == child_node
    end
  end

  describe :add_child do
    it 'should add a lower-cased version of the child' do
      node = TrieNode.new

      letter = 'Z'
      node.add_child(letter)

      node.children[letter].value.should == letter.downcase
    end
  end
end
