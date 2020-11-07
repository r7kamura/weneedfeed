# frozen_string_literal: true

require 'faraday'
require 'nokogiri'

module Weneedfeed
  class Scraping
    # @param [String] item_description_selector
    # @param [String] item_link_selector
    # @param [String] item_time_selector
    # @param [String] item_title_selector
    # @param [String] item_selector
    # @param [String] title
    # @param [String] url
    def initialize(
      item_description_selector:,
      item_link_selector:,
      item_time_selector:,
      item_title_selector:,
      item_selector:,
      title:,
      url:
    )
      @item_description_selector = item_description_selector
      @item_link_selector = item_link_selector
      @item_time_selector = item_time_selector
      @item_title_selector = item_title_selector
      @item_selector = item_selector
      @title = title
      @url = url
    end

    # @return [Weneedfeed::Page]
    def call
      ::Weneedfeed::Page.new(
        node: parsed_body,
        item_description_selector: @item_description_selector,
        item_selector: @item_selector,
        item_link_selector: @item_link_selector,
        item_time_selector: @item_time_selector,
        item_title_selector: @item_title_selector,
        title: @title,
        url: @url
      )
    end

    private

    # @return [Nokogiri::Node]
    def parsed_body
      ::Nokogiri::HTML.parse(response.body)
    end

    # @return [Faraday::Response]
    def response
      ::Faraday.get(@url)
    end
  end
end
