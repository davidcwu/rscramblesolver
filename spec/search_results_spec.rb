require 'spec_helper'

include Rscramblesolver

describe SearchResults do
  it 'should initialize properly' do
    SearchResults.new
  end

  it 'should respond to add' do
    search_results = SearchResults.new
    search_results.should respond_to(:add)
  end
end