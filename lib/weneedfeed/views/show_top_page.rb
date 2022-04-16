# frozen_string_literal: true

module Weneedfeed
  module Views
    class ShowTopPage < Base
      # @param [Weneedfeed::Schema] schema
      def initialize(schema:, **argv)
        super(**argv)
        @schema = schema
      end

      private

      # @return [String]
      def base_path
        request.path.delete_suffix(router.path(:top_page))
      end

      # @param [String] page_id
      # @return [String]
      def feed_path(page_id:)
        "#{base_path}#{router.path(:feed, page_id: page_id)}"
      end

      # @return [String]
      def opml_path
        "#{base_path}#{router.path(:opml)}"
      end

      # @return [Array<String>]
      def page_schemata
        @schema.page_schemata.sort_by(&:title)
      end

      # @return [Hanami::Router]
      def router
        ::Weneedfeed::Application.router
      end
    end
  end
end
