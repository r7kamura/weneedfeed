# frozen_string_literal: true

module Weneedfeed
  class Page
    # @return [String, nil]
    attr_reader :description

    # @return [String]
    attr_reader :title

    # @return [String]
    attr_reader :url

    # @param [String, nil] description
    # @param [String, nil] item_description_selector
    # @param [String] item_link_selector
    # @param [String, nil] item_time_selector
    # @param [String] item_title_selector
    # @param [String] item_selector
    # @param [Nokogiri::Node] node
    # @param [String] title
    # @param [String] url
    def initialize(
      description:,
      item_description_selector:,
      item_link_selector:,
      item_time_selector:,
      item_title_selector:,
      item_selector:,
      node:,
      title:,
      url:
    )
      @description = description
      @item_description_selector = item_description_selector
      @item_link_selector = item_link_selector
      @item_time_selector = item_time_selector
      @item_title_selector = item_title_selector
      @item_selector = item_selector
      @node = node
      @title = title
      @url = url
    end

    # @return [Array<Weneedfeed::Item>]
    def items
      @node.search(@item_selector).map do |node|
        ::Weneedfeed::Item.new(
          description_selector: @item_description_selector,
          link_selector: @item_link_selector,
          node: node,
          time_selector: @item_time_selector,
          title_selector: @item_title_selector,
          url: @url
        )
      end
    end
  end
end
