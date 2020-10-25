module Weneedfeed
  module Controllers
    class ShowFeed < ::Hibana::Controller
      def call
        env = request.env
        properties = env.dig(
          'weneedfeed.schema',
          'pages',
          env.dig(
            'router.params',
            :page_name
          )
        )
        scraping = ::Weneedfeed::Scraping.new(
          item_description_xpath: properties['xpath']['item_description'],
          item_link_xpath: properties['xpath']['item_link'],
          item_time_xpath: properties['xpath']['item_time'],
          item_title_xpath: properties['xpath']['item_title'],
          item_xpath: properties['xpath']['item'],
          title: properties['title'],
          url: properties['url'],
        )
        page = scraping.call

        response.content_type = 'application/rss+xml; charset=utf-8'
        response.write(
          ::Weneedfeed::Views::ShowFeed.new(
            page: page,
            partial_template_path: 'templates/show_feed.xml.erb',
            request: request,
          ).to_s
        )
      end
    end
  end
end
