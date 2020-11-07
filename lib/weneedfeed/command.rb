# frozen_string_literal: true

require 'rack'
require 'thor'
require 'yaml'

module Weneedfeed
  class Command < ::Thor
    class << self
      # @note Override for thor breaking change.
      #   See https://github.com/erikhuda/thor/issues/244.
      def exit_on_failure?
        true
      end
    end

    desc(
      'build',
      'Build static files for feeds.'
    )

    method_option(
      :base_url,
      desc: 'Base URL where to locate built files. (e.g. `"https://user.github.io/repo"`)',
      required: true,
      type: :string
    )

    method_option(
      :schema_path,
      default: 'weneedfeed.yml',
      desc: 'Path to weneedfeed YAML schema file.',
      type: :string
    )

    # @param [String] base_url
    # @param [String] schema_path
    def build
      ::Weneedfeed::Capture.call(
        base_url: options[:base_url],
        schema_path: options[:schema_path]
      )
    end

    desc(
      'server',
      'Run HTTP server'
    )

    method_option(
      :schema_path,
      default: 'weneedfeed.yml',
      desc: 'Path to weneedfeed YAML schema file.',
      type: :string
    )

    def server
      schema = ::YAML.load_file(options[:schema_path])
      application = Weneedfeed::Application.new(schema: schema)
      ::Rack::Handler.default.run(application)
    end
  end
end
