# Read merchant.yaml

require "yaml"
require "pathname"

module YellowPages
  module Merchant
    def self.merchants
      path = Pathname.new(__dir__).join("merchants.yaml")
      @merchants ||= YAML.load_file(path)
    end

    def self.lookup(network_id:)
      merchants.find { |m| m["network_ids"]&.include?(network_id) }&.[]("name")
    end

    def self.icon(network_id:)
      slug = lookup(network_id:) # .gsub(/[ '-]/, '').downcase
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
