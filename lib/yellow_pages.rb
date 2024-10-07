# frozen_string_literal: true

require "yaml"

require_relative "yellow_pages/version"
require_relative "yellow_pages/merchant"
require_relative "yellow_pages/category"

module YellowPages
  class Error < StandardError; end

  class << self
    # GEM CONFIGURATIONS

    # An optional method that is called when a merchant is not found in the
    # dataset during a lookup.
    # Takes in one argument, the `network_id` of the missing merchant.
    attr_accessor :missing_merchant_reporter
  end
end
