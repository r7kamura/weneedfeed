# frozen_string_literal: true

# For faraday_middleware/response_middleware.
# https://github.com/r7kamura/weneedfeed/issues/19
require 'active_support'
require 'active_support/isolated_execution_state' if ActiveSupport.gem_version >= Gem::Version.new('7')

require 'active_support/core_ext/array/conversions'
require 'active_support/core_ext/hash/conversions'
require 'faraday'
require 'faraday_middleware/response_middleware'
require 'json'

module Weneedfeed
  class FaradayResponseMiddleware < ::FaradayMiddleware::ResponseMiddleware
    define_parser do |body, options|
      options ||= {}
      options = { dasherize: false }.merge(options)
      object = ::JSON.parse(body)
      object.to_xml(options)
    end

    # @note Overriding.
    def parse_response?(env)
      env.response.headers['Content-Type'].to_s.include?('application/json')
    end
  end
end
