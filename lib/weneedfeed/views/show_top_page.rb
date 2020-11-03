# frozen_string_literal: true

module Weneedfeed
  module Views
    class ShowTopPage < ::Hibana::View
      # @param [Array<Weneedfeed::Page>] pages
      def initialize(pages:, **argv)
        super(**argv)
        @pages = pages
      end
    end
  end
end
