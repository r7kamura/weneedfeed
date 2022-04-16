# frozen_string_literal: true

module Weneedfeed
  module Views
    class ShowOpml < Base
      # @param [Weneedfeed::Schema] schema
      def initialize(schema:, **argv)
        super(**argv)
        @schema = schema
      end

      private

      # @return [String]
      def base_path
        request.path.delete_suffix(router.path(:opml))
      end

      # @param [String] page_id
      # @return [String]
      def feed_path(page_id:)
        "#{base_path}#{router.path(:feed, page_id: page_id)}"
      end

      # @return [Array<String>]
      def page_schemata
        @schema.page_schemata.sort_by(&:title)
      end
    end
  end
end
