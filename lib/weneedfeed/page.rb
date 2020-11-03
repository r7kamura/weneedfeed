# frozen_string_literal: true

module Weneedfeed
  class Page
    # @return [String]
    attr_reader :title

    # @return [String]
    attr_reader :url

    # @param [String] item_description_xpath
    # @param [String] item_link_xpath
    # @param [String] item_time_xpath
    # @param [String] item_title_xpath
    # @param [String] item_xpath
    # @param [Nokogiri::Node] node
    # @param [String] title
    # @param [String] url
    def initialize(
      item_description_xpath:,
      item_link_xpath:,
      item_time_xpath:,
      item_title_xpath:,
      item_xpath:,
      node:,
      title:,
      url:
    )
      @item_description_xpath = item_description_xpath
      @item_link_xpath = item_link_xpath
      @item_time_xpath = item_time_xpath
      @item_title_xpath = item_title_xpath
      @item_xpath = item_xpath
      @node = node
      @title = title
      @url = url
    end

    # @return [Array<Weneedfeed::Item>]
    def items
      @node.xpath(@item_xpath).map do |node|
        ::Weneedfeed::Item.new(
          description_xpath: @item_description_xpath,
          link_xpath: @item_link_xpath,
          node: node,
          time_xpath: @item_time_xpath,
          title_xpath: @item_title_xpath,
          url: @url
        )
      end
    end
  end
end
