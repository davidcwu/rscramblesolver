module Rscramblesolver
	module Dictionary
    class SimpleDictionary

      def initialize(args)
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
        word_list.include?(potential_word)
      end

    end
	end
end
