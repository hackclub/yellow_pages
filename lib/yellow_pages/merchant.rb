# Read merchant.yaml

require "yaml"
require "net/http"

module YellowPages
  module Merchant
    def self.lookup(network_id:)
      categorized_yaml_data.find do |entry|
        # Entry could be an array of strings or a string
        entry["network_id"] == network_id || entry["network_ids"]&.include?(network_id)
      end&.dig("name")
    end

    class << self
      private

      def categorized_yaml_data
        initialize_remote_data || initialize_local_data
      end

      def initialize_remote_data
        @yaml_data ||= begin
          url = "https://gist.githubusercontent.com/maxwofford/c6057bb81629197a970610b6889945bf/raw/1db71902b11020f7f6730f71dd86461e35df8cc9/yellow_pages.yaml"
          response = ::Net::HTTP.get_response(URI(url))

          raise "Failed to fetch yaml data" unless response.code == "200"

          YAML.safe_load(response.body)
        end
      end

      def initialize_local_data
        @yaml_data ||= YAML.load_file("yellow_pages/merchants.yaml")
      end
    end
  end
end
