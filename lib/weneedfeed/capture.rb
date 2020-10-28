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
          schema_path: schema_path,
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
          url: url,
        )
      end
    end

    private

    # @return [Weneedfeed::Application]
    def app
      @app ||= ::Weneedfeed::Application.new(schema: schema)
    end

    # @return [Array<String>]
    def page_names
      schema['pages'].keys
    end

    # @return [Hash]
    def schema
      @schema ||= ::YAML.load_file(@schema_path)
    end

    # @return [Array<String>]
    def urls
      page_names.map do |page_name|
        [
          @base_url,
          page_name,
        ].join('/')
      end
    end
  end
end
