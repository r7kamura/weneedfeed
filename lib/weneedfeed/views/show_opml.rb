# frozen_string_literal: true

module Weneedfeed
  module Views
    class ShowOpml < Base
      # @param [Array<Hash>] page_schemata
      def initialize(page_schemata:, **argv)
        super(**argv)
        @page_schemata = page_schemata
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
    end
  end
end
