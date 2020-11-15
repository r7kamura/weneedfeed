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
        properties = env['weneedfeed.schema'].find_page_properties(page_name)
        unless properties
          response.status = 404
          return
        end

        scraping = ::Weneedfeed::Scraping.new(
          item_description_selector: properties['item_description_selector'],
          item_link_selector: properties['item_link_selector'],
          item_time_selector: properties['item_time_selector'],
          item_title_selector: properties['item_title_selector'],
          item_selector: properties['item_selector'],
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
