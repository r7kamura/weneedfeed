# frozen_string_literal: true

require 'rack'

module Weneedfeed
  module Controllers
    class Base
      include ::Weneedfeed::Helpers::Parameters

      class << self
        # @param [Hash] env
        # @return [Array]
        def call(env)
          controller = new(env: env)
          controller.call
          controller.response.finish
        end
      end

      # @return [Rack::Response]
      attr_reader :response

      # @param [Hash] env
      def initialize(env:)
        @env = env
        @response = ::Rack::Response.new
      end

      def call
        raise ::NotImplementedError
      end

      private

      # @return [Rack::Request]
      def request
        @request ||= ::Rack::Request.new(@env)
      end

      # @return [Weneedfeed::Schema]
      def schema
        request.env['weneedfeed.schema']
      end
    end
  end
end
