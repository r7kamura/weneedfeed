# frozen_string_literal: true

module Weneedfeed
  module Views
    class ShowTopPage < ::Hibana::View
      # @param [Array<Hash>] page_schemata
      def initialize(page_schemata:, **argv)
        super(**argv)
        @page_schemata = page_schemata
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

      # @return [Hanami::Router]
      def router
        ::Weneedfeed::Application.router
      end
    end
  end
end
