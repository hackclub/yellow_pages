# Read merchant.yaml

require "yaml"
require "pathname"

module YellowPages
  class Merchant
    # Returns all the merchants and their network IDs
    #
    # @return [Hash] the raw merchant hashes
    def self.merchants
      @merchants ||=
        begin
          path = Pathname.new(__dir__).join("merchants.yaml")
          yaml = YAML.load_file(path)
          yaml.flat_map do |merchant|
            next if merchant["name"].nil?

            merchant["network_ids"].map do |nid|
              filename = merchant["name"].gsub(/[ '-]/, "").downcase
              filepath = Pathname.new(__dir__).join("../assets/icons/#{filename}.svg")

              [nid, {name: merchant["name"], icon_filepath: filepath}]
            end
          end.compact.to_h
        end
    end

    def initialize(network_id:)
      @network_id = network_id
    end

    # Returns merchant name
    #
    # @return [String, nil] the name of the merchant, if found
    def name
      merchant&.fetch(:name)
    end

    # Returns an SVG logo icon of the merchant
    #
    # @return [String, nil] the SVG code of the merchant, if found
    def icon
      @icon ||=
        begin
          path = merchant&.fetch(:icon_filepath)
          File.read(path) if path
        rescue Errno::ENOENT
          nil
        end
    end

    # Returns true if the merchant is in the dataset
    # @return [Boolean] whether the merchant is in our dataset
    def in_dataset?
      !merchant.nil?
    end

    private

    def merchant
      self.class.merchants[@network_id]
    end
  end
end
