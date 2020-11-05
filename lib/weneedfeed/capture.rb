# frozen_string_literal: true

require 'rack/capture'
require 'yaml'

module Weneedfeed
  class Capture
    class << self
      # @param [String] base_url
      # @param [String] schema_path
      def call(
        base_url:,
        schema_path:
      )
        new(
          base_url: base_url,
          schema_path: schema_path
        ).call
      end
    end

    # @param [String] base_url
    # @param [String] schema_path
    def initialize(
      base_url:,
      schema_path:
    )
      @base_url = base_url
      @schema_path = schema_path
    end

    def call
      urls.each do |url|
        ::Rack::Capture.call(
          app: app,
          script_name: script_name,
          url: url
        )
      end
    end

    private

    # @return [Weneedfeed::Application]
    def app
      @app ||= ::Weneedfeed::Application.new(
        schema: ::YAML.load_file(@schema_path)
      )
    end

    # @return [URI]
    def base_uri
      @base_uri ||= ::URI.parse(@base_url)
    end

    # @return [Hash]
    def schema
      ::YAML.load_file(@schema_path)
    end

    # @return [String]
    def script_name
      case base_uri.path
      when '', '/'
        ''
      else
        base_uri.path
      end
    end

    # @return [Array<String>]
    def urls
      app.paths.map do |path|
        [
          @base_url,
          path
        ].join
      end
    end
  end
end
