require 'spec_helper'

require 'rscramblesolver/dictionary/word_reader'


include Rscramblesolver::Dictionary

describe WordReader do

	it "should initialize (this is an expensive test)" do
		WordReader.new
	end
end