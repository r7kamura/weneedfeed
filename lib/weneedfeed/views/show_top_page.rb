# frozen_string_literal: true

module Weneedfeed
  module Views
    class ShowTopPage < ::Hibana::View
      # @param [Array<Weneedfeed::Page>] pages
      def initialize(pages:, **argv)
        super(**argv)
        @pages = pages
      end

      private

      # @return [String]
      def base_path
        request.path.delete_suffix(router.path(:top_page))
      end

      # @param [String] page_name
      # @return [String]
      def feed_path(page_name:)
        "#{base_path}#{router.path(:feed, page_name: page_name)}"
      end

      # @return [Hanami::Router]
      def router
        ::Weneedfeed::Application.router
      end
    end
  end
end
