require 'faraday'
require 'nokogiri'
require 'yaml'

module Weneedfeed
  class Page
    # @param [String] name
    # @param [Hash] properties
    def initialize(name:, properties:)
      @name = name
      @properties = properties
    end

    # @return [Array]
    def items
      body.xpath(@properties['xpath']['item']).map do |node|
        {
          description: node.xpath(@properties['xpath']['item_description']).inner_html,
          link: node.xpath(@properties['xpath']['item_link']).inner_html,
          time: ::Time.parse(node.xpath(@properties['xpath']['item_time']).inner_html),
          title: node.xpath(@properties['xpath']['item_title']).inner_text,
        }
      end
    end

    private

    # @return [Nokogiri::Node]
    def body
      ::Nokogiri::HTML.parse(response.body)
    end

    # @return [String]
    def page_url
      @page_url ||= @properties['url']
    end

    # @return [Faraday::Response]
    def response
      ::Faraday.get(page_url)
    end
  end
end
