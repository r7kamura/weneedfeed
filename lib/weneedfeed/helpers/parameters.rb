# frozen_string_literal: true

module Weneedfeed
  module Helpers
    module Parameters
      private

      # @return [Hash]
      def path_parameters
        request.env['router.params']
      end
    end
  end
end
