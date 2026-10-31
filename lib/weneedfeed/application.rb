# frozen_string_literal: true

module Weneedfeed
  class Application
    class << self
      # @return [Weneedfeed::Router]
      def router
        @router ||= ::Weneedfeed::Router.new.tap do |router|
          router.get '/', to: ::Weneedfeed::Controllers::ShowTopPage, as: :top_page
          router.get '/feeds/:page_id.xml', to: ::Weneedfeed::Controllers::ShowFeed, as: :feed
          router.get '/opml.xml', to: ::Weneedfeed::Controllers::ShowOpml, as: :opml
        end
      end
    end

    # @param [String] schema_path
    def initialize(schema_path:)
      @schema = ::Weneedfeed::Schema.load_file(schema_path)
    end

    # @param [Hash] env
    def call(env)
      env['weneedfeed.schema'] = @schema
      self.class.router.call(env)
    end

    # @return [Array<String>]
    def paths
      %w[
        /
        /opml.xml
      ] + @schema.page_ids.map do |page_id|
        "/feeds/#{page_id}.xml"
      end
    end
  end
end
