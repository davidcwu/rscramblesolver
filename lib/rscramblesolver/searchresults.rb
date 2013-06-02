module Rscramblesolver
  class SearchResults
    attr_reader :results

    def initialize
      @results = []
    end

    def add(result)
      results << result
    end

    def to_s
      results
    end
  end
end
