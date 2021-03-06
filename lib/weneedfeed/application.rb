# frozen_string_literal: true

require 'hibana'

module Weneedfeed
  class Application < ::Hibana::Application
    route do
      get '/', to: ::Weneedfeed::Controllers::ShowTopPage, as: :top_page
      get '/feeds/:page_id.xml', to: ::Weneedfeed::Controllers::ShowFeed, as: :feed
    end

    # @param [Hash] schema
    def initialize(schema:)
      @schema = ::Weneedfeed::Schema.new(schema)
      super()
    end

    # @param [Hash] env
    def call(env)
      env['weneedfeed.schema'] = @schema
      super
    end

    # @return [Array<String>]
    def paths
      ['/'] + @schema.page_ids.map do |page_id|
        "/feeds/#{page_id}.xml"
      end
    end
  end
end
