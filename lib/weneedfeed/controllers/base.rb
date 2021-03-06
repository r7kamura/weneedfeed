# frozen_string_literal: true

module Weneedfeed
  module Controllers
    class Base < ::Hibana::Controller
      include ::Weneedfeed::Helpers::Parameters

      private

      # @return [Weneedfeed::Schema]
      def schema
        request.env['weneedfeed.schema']
      end
    end
  end
end
