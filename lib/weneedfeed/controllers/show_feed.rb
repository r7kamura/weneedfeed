# frozen_string_literal: true

module Weneedfeed
  module Controllers
    class ShowFeed < ::Hibana::Controller
      def call
        env = request.env
        page_name = env.dig(
          'router.params',
          :page_name
        )
        properties = env.dig(
          'weneedfeed.schema',
          'pages',
          page_name
        )
        unless properties
          response.status = 404
          return
        end

        scraping = ::Weneedfeed::Scraping.new(
          item_description_selector: properties['selectors']['item_description'],
          item_link_selector: properties['selectors']['item_link'],
          item_time_selector: properties['selectors']['item_time'],
          item_title_selector: properties['selectors']['item_title'],
          item_selector: properties['selectors']['item'],
          title: properties['title'],
          url: properties['url']
        )
        page = scraping.call

        response.content_type = 'application/xml; charset=utf-8'
        response.write(
          ::Weneedfeed::Views::ShowFeed.new(
            page: page,
            partial_template_path: ::File.expand_path(
              'templates/show_feed.xml.erb',
              "#{__dir__}/../../.."
            ),
            request: request
          ).to_s
        )
      end
    end
  end
end
