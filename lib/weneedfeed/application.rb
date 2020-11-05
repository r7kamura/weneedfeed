# frozen_string_literal: true

require 'hibana'

module Weneedfeed
  class Application < ::Hibana::Application
    route do
      get '/', to: ::Weneedfeed::Controllers::ShowTopPage
      get '/feeds/:page_name.xml', to: ::Weneedfeed::Controllers::ShowFeed
    end

    # @param [Hash] schema
    def initialize(schema:)
      @schema = schema
      super()
    end

    # @param [Hash] env
    def call(env)
      env['weneedfeed.schema'] = @schema
      super
    end

    # @return [Array<String>]
    def paths
      ['/'] + @schema['pages'].keys.map do |page_name|
        "/feeds/#{page_name}.xml"
      end
    end
  end
end
