RSpec.describe YellowPages::Merchant do
  it "exists" do
    expect(YellowPages::Merchant).not_to be nil
  end

  it "has a lookup method" do
    expect(YellowPages::Merchant).to respond_to(:lookup)
  end

  it "returns a merchant name for a found network ID" do
    expect(YellowPages::Merchant.lookup(network_id: "1234567890")).to eq("name" => "Rocket Rides", "network_id" => "1234567890")
  end

  it "returns nil for an unfound network ID" do
    expect(YellowPages::Merchant.lookup(network_id: "NONEXISTANT_MERCHANT_ID")).to be_nil
  end

  it "returns a merchant name for a found network ID" do
    expect(YellowPages::Merchant.lookup_name(network_id: "1234567890")).to eq("Rocket Rides")
  end

  it "returns nil for an unfound network ID" do
    expect(YellowPages::Merchant.lookup_name(network_id: "NONEXISTANT_MERCHANT_ID")).to be_nil
  end
end
