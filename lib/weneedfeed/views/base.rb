# frozen_string_literal: true

module Weneedfeed
  module Views
    class Base < ::Hibana::View
      private

      # @return [Hanami::Router]
      def router
        ::Weneedfeed::Application.router
      end
    end
  end
end
