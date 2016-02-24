require_relative 'html_generator'
require_relative 'header_generator'
require_relative 'word_search'
require_relative 'game'

module HTTP
  class Application
    include StatusCodes

    def initialize
      @hello_count = 0
      @total_requests = 0
    end

    def root

    end

    def not_found

    end

    def datetime

    end

    def hello

    end

    def shutdown

    end

    def word_search

    end

    def game

    end
  end
end
