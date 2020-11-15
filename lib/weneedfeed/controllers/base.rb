# frozen_string_literal: true

module Weneedfeed
  module Controllers
    class Base < ::Hibana::Controller
      include ::Weneedfeed::Helpers::Parameters
    end
  end
end
