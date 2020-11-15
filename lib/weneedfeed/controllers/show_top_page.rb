# frozen_string_literal: true

module Weneedfeed
  module Controllers
    class ShowTopPage < ::Weneedfeed::Controllers::Base
      def call
        page_schemata = request.env['weneedfeed.schema'].page_schemata.sort_by(&:title)
        response.content_type = 'text/html'
        response.write(
          ::Weneedfeed::Views::ShowTopPage.new(
            page_schemata: page_schemata,
            partial_template_path: ::File.expand_path(
              'templates/show_top_page.html.erb',
              "#{__dir__}/../../.."
            ),
            request: request
          ).to_s
        )
      end
    end
  end
end
