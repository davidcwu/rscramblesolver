module Rscramblesolver
	module Dictionary
		class WordReader
			attr_reader :word_list

			def initialize
				@word_list = parse_file(words_directory)
			end

			private

				def parse_file(dir)
					word_list = []
					open(dir, 'r') do |file|
						file.each_line do |line|
							word_list << line.chomp
						end
					end

					return word_list
				end

				def words_directory
					"data/words"
				end
		end
	end
end