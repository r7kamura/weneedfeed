# frozen_string_literal: true

require 'yaml'

module Weneedfeed
  class Schema
    class << self
      # @param [String] schema_path
      # @return [Weneedfeed::Schema]
      def load_file(schema_path)
        raw = ::YAML.load_file(schema_path, aliases: true)
        new(raw)
      end
    end

    # @param [Hash] raw
    def initialize(raw)
      @raw = raw
    end

    # @param [String, nl] page_schema_id
    # @return [Weneedfeed::PageSchema]
    def find_page_schema(page_schema_id)
      page_schemata.find do |page_schema|
        page_schema.id == page_schema_id
      end
    end

    # @return [Array<String>]
    def page_ids
      page_schemata.map(&:id)
    end

    # @return [Array<Weneedfeed::PageSchema>]
    def page_schemata
      @raw['pages'].map do |hash|
        ::Weneedfeed::PageSchema.new(
          description: hash['description'],
          id: hash['id'],
          item_description_selector: hash['item_description_selector'],
          item_image_selector: hash['item_image_selector'],
          item_link_selector: hash['item_link_selector'],
          item_time_selector: hash['item_time_selector'],
          item_title_selector: hash['item_title_selector'],
          item_selector: hash['item_selector'],
          title: hash['title'],
          url: hash['url'],
        )
      end
    end
  end
end
