module Rscramblesolver
	module Dictionary
    class SimpleDictionary

      def initialize(args = {})
        @word_reader = args[:word_reader] || WordReader.new
      end

      def word_list
        @word_reader.word_list
      end

      # Returning false for now since I'm not implementing 
      # this method for a simple dictionary
      def prefix_for_real_word?(prefix)
        return false
      end

      def real_word?(potential_word)
        word_hash[potential_word.length].include?(potential_word)
      end

      private
        require 'set'

        def word_hash
          @word_hash ||= word_hash_internal
        end

        # Creates a hash from word length to a set of words with that word length
        def word_hash_internal
          hash = Hash.new(Set.new)
          word_list.each do |word|
            hash[word.length].add(word)
          end
          return hash
        end
    end
	end
end
