# Read merchant.yaml

module YellowPages
  module Merchant
    self.lookup(network_id:)
      categorized_yaml_data.find do |entry|
        # Entry could be an array of strings or a string
        entry['network_id'] == network_id || entry['network_ids']&.include?(network_id)
      end
    end
  end
end
