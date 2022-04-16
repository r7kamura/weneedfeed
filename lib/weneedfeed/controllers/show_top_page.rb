# frozen_string_literal: true

module Weneedfeed
  module Controllers
    class ShowTopPage < ::Weneedfeed::Controllers::Base
      def call
        response.content_type = 'text/html'
        response.write(
          ::Weneedfeed::Views::ShowTopPage.new(
            partial_template_path: ::File.expand_path(
              'templates/show_top_page.html.erb',
              "#{__dir__}/../../.."
            ),
            request: request,
            schema: schema
          ).to_s
        )
      end
    end
  end
end
