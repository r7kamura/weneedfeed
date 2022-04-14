# frozen_string_literal: true

require 'addressable'
require 'marcel'

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

    # @param [String, nil] description_selector
    # @param [String, nil] image_selector
    # @param [String, nil] link_selector
    # @param [Nokogiri::Node] node
    # @param [String] time_selector
    # @param [String] title_selector
    # @param [String] url
    def initialize(
      description_selector:,
      image_selector:,
      link_selector:,
      node:,
      time_selector:,
      title_selector:,
      url:
    )
      @description_selector = description_selector
      @image_selector = image_selector
      @link_selector = link_selector
      @node = node
      @time_selector = time_selector
      @title_selector = title_selector
      @url = url
    end

    # @return [String, nil]
    def description
      return unless @description_selector

      @node.at(@description_selector)&.inner_html
    end

    # @return [String, nil]
    def image_mime_type
      return unless image_url

      ::Marcel::Magic.by_path(image_url)&.type
    end

    # @return [String, nil]
    def image_path_or_url
      return unless @image_selector

      node = @node.at(@image_selector)
      return unless node

      if node.name == 'img'
        node['src']
      else
        node.content
      end
    end

    def image_url
      return unless image_path_or_url

      ::Addressable::URI.join(
        @url,
        image_path_or_url
      ).normalize.to_s
    end

    # @return [String]
    def link
      return unless link_path_or_url

      ::Addressable::URI.join(
        @url,
        link_path_or_url
      ).normalize.to_s
    end

    # @return [Nokogiri::Node, nil]
    def link_node
      @node.at(@link_selector)
    end

    # @return [String, nil]
    def link_path_or_url
      node = link_node
      return unless node

      node['href'] || node.inner_text
    end

    # @return [Time, nil]
    def time
      return unless @time_selector

      string = time_string
      return unless string

      self.class.parse_time(string)
    end

    # @return [String, nil]
    def title
      @node.at(@title_selector)&.inner_text
    end

    private

    # @return [Nokogiri::Node, nil]
    def time_node
      @node.at(@time_selector)
    end

    # @return [String, nil]
    def time_string
      node = time_node
      return unless node

      node['datetime'] || node.inner_text
    end
  end
end
