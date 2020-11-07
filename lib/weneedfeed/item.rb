# frozen_string_literal: true

module Weneedfeed
  class Item
    class << self
      # @param [String] string
      # @return [Time, nil]
      def parse_time(string)
        ::Time.parse(string)
      rescue ArgumentError, RangeError
        begin
          ::Time.strptime(string, '%Y年%m月%d日')
        rescue ArgumentError
        end
      end
    end

    # @param [String] description_selector
    # @param [String] link_selector
    # @param [Nokogiri::Node] node
    # @param [String] time_selector
    # @param [String] title_selector
    # @param [String] url
    def initialize(
      description_selector:,
      link_selector:,
      node:,
      time_selector:,
      title_selector:,
      url:
    )
      @description_selector = description_selector
      @link_selector = link_selector
      @node = node
      @time_selector = time_selector
      @title_selector = title_selector
      @url = url
    end

    # @return [String, nil]
    def description
      @node.at(@description_selector).inner_html
    end

    # @return [String]
    def link
      ::URI.join(
        @url,
        @node.at(@link_selector)['href']
      ).to_s
    end

    # @return [Time, nil]
    def time
      self.class.parse_time(time_string)
    end

    # @return [String, nil]
    def title
      @node.at(@title_selector).inner_text
    end

    private

    # @return [String]
    def time_string
      @node.at(@time_selector).inner_html
    end
  end
end
