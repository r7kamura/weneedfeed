# frozen_string_literal: true

require 'tilt'

module Weneedfeed
  module Views
    class Base
      # @param [String] partial_template_path
      # @param [Rack::Request] request
      def initialize(
        partial_template_path:,
        request:
      )
        @partial_template_path = partial_template_path
        @request = request
      end

      # @return [String]
      def to_s
        ::Tilt.new(@partial_template_path).render(self)
      end

      private

      # @return [Rack::Request]
      attr_reader :request

      # @return [Weneedfeed::Router]
      def router
        ::Weneedfeed::Application.router
      end
    end
  end
end
