module Weneedfeed
  module Controllers
    class ShowTopPage < ::Hibana::Controller
      def call
        pages = request.env.dig(
          'weneedfeed.schema',
          'pages',
        )
        response.content_type = 'text/html'
        response.write(
          ::Weneedfeed::Views::ShowTopPage.new(
            pages: pages,
            partial_template_path: 'templates/show_top_page.html.erb',
            request: request,
          ).to_s
        )
      end
    end
  end
end
