require 'faraday'
require 'nokogiri'

module Weneedfeed
  class Scraping
    # @param [String] item_description_xpath
    # @param [String] item_link_xpath
    # @param [String] item_time_xpath
    # @param [String] item_title_xpath
    # @param [String] item_xpath
    # @param [String] name
    # @param [String] title
    # @param [String] url
    def initialize(
      item_description_xpath:,
      item_link_xpath:,
      item_time_xpath:,
      item_title_xpath:,
      item_xpath:,
      name:,
      title:,
      url:
    )
      @item_description_xpath = item_description_xpath
      @item_link_xpath = item_link_xpath
      @item_time_xpath = item_time_xpath
      @item_title_xpath = item_title_xpath
      @item_xpath = item_xpath
      @name = name
      @title = title
      @url = url
    end

    # @return [Weneedfeed::Page]
    def call
      ::Weneedfeed::Page.new(
        node: parsed_body,
        item_description_xpath: @item_description_xpath,
        item_xpath: @item_xpath,
        item_link_xpath: @item_link_xpath,
        item_time_xpath: @item_time_xpath,
        item_title_xpath: @item_title_xpath,
        url: @url,
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
