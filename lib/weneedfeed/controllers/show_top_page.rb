# frozen_string_literal: true

module Weneedfeed
  module Controllers
    class ShowTopPage < ::Hibana::Controller
      def call
        pages = request.env['weneedfeed.schema'].pages.sort_by do |_key, value|
          value['title']
        end
        response.content_type = 'text/html'
        response.write(
          ::Weneedfeed::Views::ShowTopPage.new(
            pages: pages,
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
