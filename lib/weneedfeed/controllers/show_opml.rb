# frozen_string_literal: true

module Weneedfeed
  module Controllers
    class ShowOpml < ::Weneedfeed::Controllers::Base
      def call
        response.content_type = 'application/xml; charset=utf-8'
        response.write(
          ::Weneedfeed::Views::ShowOpml.new(
            page_schemata: schema.page_schemata.sort_by(&:title),
            partial_template_path: ::File.expand_path(
              'templates/show_opml.xml.erb',
              "#{__dir__}/../../.."
            ),
            request: request
          ).to_s
        )
      end
    end
  end
end
