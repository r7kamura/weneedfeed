# frozen_string_literal: true

require 'weneedfeed/version'

module Weneedfeed
  autoload :Application, 'weneedfeed/application'
  autoload :Capture, 'weneedfeed/capture'
  autoload :Command, 'weneedfeed/command'
  autoload :Controllers, 'weneedfeed/controllers'
  autoload :Item, 'weneedfeed/item'
  autoload :Page, 'weneedfeed/page'
  autoload :Schema, 'weneedfeed/schema'
  autoload :Scraping, 'weneedfeed/scraping'
  autoload :Views, 'weneedfeed/views'
end
