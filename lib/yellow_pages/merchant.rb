# Read merchant.yaml

require 'yaml'
require 'net/http'
require 'json'

module YellowPages
  module Merchant
    def self.all
      categorized_yaml_data
    end

    def self.icon(name)
      slug = name.gsub(/ /, '').downcase
      begin
        file = File.read("simple-icons/icons/#{slug}.svg")
      rescue Errno::ENOENT
        # Not in simpleicons
      end
      puts file
    end

    def self.lookup(network_id:)
      categorized_yaml_data.find do |entry|
        # Entry could be an array of strings or a string
        entry['network_id'] == network_id || entry['network_ids']&.include?(network_id)
      end
    end

    def self.method_missing(method_name, *args)
      return unless /lookup_(?<key>.+)/ =~ method_name

      lookup(network_id: args.first[:network_id])&.dig(key.to_s)
    end

    def self.respond_to_missing?(method_name, include_private = false)
      method_name.to_s.start_with?('lookup_') || super
    end

    class << self
      private

      def categorized_yaml_data
        initialize_remote_data || initialize_local_data
      end

      def initialize_remote_data
        @yaml_data ||= begin
          url = 'https://gist.githubusercontent.com/maxwofford/c6057bb81629197a970610b6889945bf/raw/1db71902b11020f7f6730f71dd86461e35df8cc9/yellow_pages.yaml'
          response = ::Net::HTTP.get_response(URI(url))

          raise 'Failed to fetch yaml data' unless response.code == '200'

          YAML.safe_load(response.body)
        end
      end

      def initialize_local_data
        @yaml_data ||= YAML.load_file('yellow_pages/merchants.yaml')
      end

      def simpleicons_data
        @simpleicons_data ||= JSON.parse(File.read('simple-icons/_data/simple-icons.json'))['icons']
      end
    end
  end
end
