# frozen_string_literal: true

module Weneedfeed
  PageSchema = Struct.new(
    :description,
    :id,
    :item_description_selector,
    :item_link_selector,
    :item_time_selector,
    :item_title_selector,
    :item_selector,
    :title,
    :url,
    keyword_init: true,
  )
end
