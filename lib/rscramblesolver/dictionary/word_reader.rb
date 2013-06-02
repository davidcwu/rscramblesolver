require 'zlib'

module Rscramblesolver
	module Dictionary
		class WordReader

			def word_list
				@word_list ||= parse_file(words_directory)
			end

			private
				include Zlib

				def parse_file(path)
					word_list = []
					open(path, 'r') do |file|
						unzipped_file = Zlib::GzipReader.new(file)
						unzipped_file.each_line do |line|
							word_list << line.chomp
						end
					end

					return word_list
				end

				def words_directory
					"data/words.dat.gz"
				end
		end
	end
end
