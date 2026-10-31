# frozen_string_literal: true

require 'rack'

module Weneedfeed
  class Router
    Route = ::Struct.new(
      :controller,
      :name,
      :path,
      :regexp,
      keyword_init: true
    )

    def initialize
      @routes = []
    end

    # @param [String] path
    # @param [#call] to
    # @param [Symbol] as
    def get(
      path,
      as:,
      to:
    )
      @routes << Route.new(
        controller: to,
        name: as,
        path: path,
        regexp: to_regexp(path)
      )
    end

    # @param [Hash] env
    # @return [Array]
    def call(env)
      if %w[GET HEAD].include?(env['REQUEST_METHOD'])
        @routes.each do |route|
          match_data = route.regexp.match(env['PATH_INFO'])
          next unless match_data

          env['router.params'] = match_data.named_captures.to_h do |key, value|
            [key.to_sym, ::Rack::Utils.unescape_path(value)]
          end
          return route.controller.call(env)
        end
      end

      [404, { 'content-type' => 'text/plain' }, ['Not Found']]
    end

    # @param [Symbol] name
    # @param [Hash{Symbol => String}] parameters
    # @return [String]
    def path(
      name,
      **parameters
    )
      route = @routes.find { |element| element.name == name }
      raise ::ArgumentError, "Unknown route: #{name}" unless route

      route.path.gsub(/:(\w+)/) do
        ::Rack::Utils.escape_path(parameters.fetch(::Regexp.last_match(1).to_sym).to_s)
      end
    end

    private

    # @param [String] path
    # @return [Regexp]
    def to_regexp(path)
      pattern = ::Regexp.escape(path).gsub(/:(\w+)/) do
        "(?<#{::Regexp.last_match(1)}>[^/]+?)"
      end
      /\A#{pattern}\z/
    end
  end
end
