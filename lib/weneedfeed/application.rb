# frozen_string_literal: true

require 'hibana'

module Weneedfeed
  class Application < ::Hibana::Application
    route do
      get '/', to: ::Weneedfeed::Controllers::ShowTopPage, as: :top_page
      get '/feeds/:page_id.xml', to: ::Weneedfeed::Controllers::ShowFeed, as: :feed
      get '/opml.xml', to: ::Weneedfeed::Controllers::ShowOpml, as: :opml
    end

    # @param [String] schema_path
    def initialize(schema_path:)
      @schema = ::Weneedfeed::Schema.load_file(schema_path)
      super()
    end

    # @param [Hash] env
    def call(env)
      env['weneedfeed.schema'] = @schema
      super
    end

    # @return [Array<String>]
    def paths
      %w[
        /
        /opml
      ] + @schema.page_ids.map do |page_id|
        "/feeds/#{page_id}.xml"
      end
    end
  end
end
