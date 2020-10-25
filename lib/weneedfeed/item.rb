module Weneedfeed
  class Item
    # @param [String] description_xpath
    # @param [String] link_xpath
    # @param [Nokogiri::Node] node
    # @param [String] time_xpath
    # @param [String] title_xpath
    def initialize(
      description_xpath:,
      link_xpath:,
      node:,
      time_xpath:,
      title_xpath:
    )
      @description_xpath = description_xpath
      @link_xpath = link_xpath
      @node = node
      @time_xpath = time_xpath
      @title_xpath = title_xpath
    end

    # @return [String, nil]
    def description
      @node.xpath(@description_xpath).inner_html
    end

    # @return [String, nil]
    def link
      @node.xpath(@link_xpath).inner_html
    end

    # @return [Time, nil]
    def time
      ::Time.parse(@node.xpath(@time_xpath).inner_html)
    end

    # @return [String, nil]
    def title
      @node.xpath(@title_xpath).inner_text
    end
  end
end
