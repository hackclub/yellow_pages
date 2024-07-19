# Read merchant.yaml

require "yaml"
require "pathname"

module YellowPages
  module Merchant
    # Returns all the merchants and their network IDs
    #
    # @return [Hash] the raw merchant hashes
    def self.merchants
      path = Pathname.new(__dir__).join("merchants.yaml")
      yaml = YAML.load_file(path)
      @merchants ||= yaml.flat_map { |x| x["network_ids"].map { |y| [y, x["name"]] } }.to_h
    end

    # Looks up a merchant name from a network ID
    #
    # @param network_id [String] the ID of the merchant to look up
    # @return [String, nil] the name of the merchant, if found
    def self.lookup(network_id:)
      merchants[network_id]
    end

    # Returns an SVG logo icon of the merchant looked up from a network ID
    #
    # @param network_id [String] the ID of the merchant to look up
    # @return [String, nil] the SVG code of the merchant, if found
    def self.icon(network_id:)
      slug = lookup(network_id:).gsub(/[ '-]/, "").downcase
      path = Pathname.new(__dir__).join("../assets/icons/#{slug}.svg")
      File.read(path)
    rescue Errno::ENOENT
      nil
    end

    def self.method_missing(method_name, *args)
      return unless /lookup_(?<key>.+)/ =~ method_name

      lookup(network_id: args.first[:network_id])&.dig(key.to_s)
    end

    def self.respond_to_missing?(method_name, include_private = false)
      method_name.to_s.start_with?("lookup_") || super
    end

    class << self
      # Private methods
    end
  end
end
