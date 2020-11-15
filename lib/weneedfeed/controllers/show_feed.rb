# frozen_string_literal: true

module Weneedfeed
  module Controllers
    class ShowFeed < ::Hibana::Controller
      def call
        env = request.env
        page_id = env.dig(
          'router.params',
          :page_id
        )
        page_schema = env['weneedfeed.schema'].find_page_schema(page_id)
        unless page_schema
          response.status = 404
          return
        end

        scraping = ::Weneedfeed::Scraping.new(
          item_description_selector: page_schema.item_description_selector,
          item_link_selector: page_schema.item_link_selector,
          item_time_selector: page_schema.item_time_selector,
          item_title_selector: page_schema.item_title_selector,
          item_selector: page_schema.item_selector,
          title: page_schema.title,
          url: page_schema.url,
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
