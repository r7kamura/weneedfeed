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

    # @param [String] description_xpath
    # @param [String] link_xpath
    # @param [Nokogiri::Node] node
    # @param [String] time_xpath
    # @param [String] title_xpath
    # @param [String] url
    def initialize(
      description_xpath:,
      link_xpath:,
      node:,
      time_xpath:,
      title_xpath:,
      url:
    )
      @description_xpath = description_xpath
      @link_xpath = link_xpath
      @node = node
      @time_xpath = time_xpath
      @title_xpath = title_xpath
      @url = url
    end

    # @return [String, nil]
    def description
      @node.xpath(@description_xpath).inner_html
    end

    # @return [String]
    def link
      ::URI.join(
        @url,
        @node.xpath(@link_xpath).inner_html
      ).to_s
    end

    # @return [Time, nil]
    def time
      self.class.parse_time(time_string)
    end

    # @return [String, nil]
    def title
      @node.xpath(@title_xpath).inner_text
    end

    private

    # @return [String]
    def time_string
      @node.xpath(@time_xpath).inner_html
    end
  end
end
