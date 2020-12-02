# frozen_string_literal: true

require 'faraday'
require 'nokogiri'

module Weneedfeed
  class Scraping
    class << self
      # @return [Faraday::Connection]
      def faraday_connection
        @faraday_connection ||= ::Faraday.new do |connection|
          connection.use ::Weneedfeed::FaradayResponseMiddleware
        end
      end
    end

    # @param [String, nil] description
    # @param [String, nil] item_description_selector
    # @param [String, nil] item_image_selector
    # @param [String] item_link_selector
    # @param [String, nil] item_time_selector
    # @param [String] item_title_selector
    # @param [String] item_selector
    # @param [String] title
    # @param [String] url
    def initialize(
      description:,
      item_description_selector:,
      item_image_selector:,
      item_link_selector:,
      item_time_selector:,
      item_title_selector:,
      item_selector:,
      title:,
      url:
    )
      @description = description
      @item_description_selector = item_description_selector
      @item_image_selector = item_image_selector
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
        description: @description,
        node: parsed_body,
        item_description_selector: @item_description_selector,
        item_image_selector: @item_image_selector,
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
      if response.headers['Content-Type']&.include?('application/json')
        ::Nokogiri::XML.parse(response.body)
      else
        ::Nokogiri::HTML.parse(response.body)
      end
    end

    # @return [Faraday::Response]
    def response
      @response ||= self.class.faraday_connection.get(@url)
    end
  end
end
