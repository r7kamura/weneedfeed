# frozen_string_literal: true

module Weneedfeed
  class Schema
    # @param [Hash] raw
    def initialize(raw)
      @raw = raw
    end

    # @param [String] page_name
    def find_page_properties(page_name)
      pages[page_name]
    end

    # @return [Array<String>]
    def page_names
      pages.keys
    end

    # @return [Hash{String => Hash}]
    def pages
      @raw['pages']
    end
  end
end
