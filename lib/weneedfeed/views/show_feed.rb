module Weneedfeed
  module Views
    class ShowFeed < ::Hibana::View
      # @param [Weneedfeed::Page] page
      def initialize(page:, **argv)
        super(**argv)
        @page = page
      end

      private

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
    end
  end
end
