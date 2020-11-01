require 'hibana'

module Weneedfeed
  class Application < ::Hibana::Application
    route do
      get '/', to: ::Weneedfeed::Controllers::ShowTopPage
      get '/:page_name', to: ::Weneedfeed::Controllers::ShowFeed
    end

    # @param [Hash] schema
    def initialize(schema:)
      @schema = schema
    end

    # @param [Hash] env
    def call(env)
      env['weneedfeed.schema'] = @schema
      super
    end
  end
end
