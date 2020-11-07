# frozen_string_literal: true

module Weneedfeed
  module Views
    class ShowFeed < ::Hibana::View
      # @param [Weneedfeed::Page] page
      def initialize(page:, **argv)
        super(**argv)
        @page = page
      end

      private

      # @return [String]
      def top_page_path
        request.path.delete_suffix(router.path(:feed, page_name: page_name))
      end

      # @return [Enumerable<Weneedfeed::Item>]
      def items
        @page.items.sort_by do |item|
          -(item.time || ::Time.now).to_i
        end.take(10)
      end

      # @return [String]
      def page_name
        request.env['router.params'][:page_name]
      end

      # @return [Hanami::Router]
      def router
        ::Weneedfeed::Application.router
      end
    end
  end
end
