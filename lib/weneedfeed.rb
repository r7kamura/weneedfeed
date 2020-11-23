# frozen_string_literal: true

require 'weneedfeed/version'

module Weneedfeed
  autoload :Application, 'weneedfeed/application'
  autoload :Capture, 'weneedfeed/capture'
  autoload :Command, 'weneedfeed/command'
  autoload :Controllers, 'weneedfeed/controllers'
  autoload :FaradayResponseMiddleware, 'weneedfeed/faraday_response_middleware'
  autoload :Helpers, 'weneedfeed/helpers'
  autoload :Item, 'weneedfeed/item'
  autoload :Page, 'weneedfeed/page'
  autoload :PageSchema, 'weneedfeed/page_schema'
  autoload :Schema, 'weneedfeed/schema'
  autoload :Scraping, 'weneedfeed/scraping'
  autoload :Views, 'weneedfeed/views'
end
