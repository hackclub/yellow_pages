RSpec.describe YellowPages::Merchant do
  it "exists" do
    expect(YellowPages::Merchant).not_to be nil
  end

  describe "::lookup" do
    it "initializes a new merchant" do
      merchant = YellowPages::Merchant.lookup(network_id: "1234567890")
      expect(merchant).to be_a YellowPages::Merchant
    end
  end

  describe "::merchants" do
    it "returns a hash of merchants keyed by their network ID" do
      merchants = YellowPages::Merchant.merchants
      expect(merchants).to be_a Hash
      expect(merchants.keys).to include("1234567890")
      expect(merchants["1234567890"].keys).to include(:name, :icon_filepath)
    end
  end

  describe "#name" do
    context "when merchant is found" do
      it "returns the merchant name" do
        merchant = YellowPages::Merchant.new(network_id: "1234567890")
        expect(merchant.name).to eq("Rocket Rides")
      end
    end

    context "when merchant is not found" do
      it "returns nil" do
        merchant = YellowPages::Merchant.new(network_id: "NONEXISTANT_MERCHANT_ID")
        expect(merchant.name).to be nil

        merchant = YellowPages::Merchant.new(network_id: nil)
        expect(merchant.name).to be nil

        merchant = YellowPages::Merchant.new(network_id: "")
        expect(merchant.name).to be nil
      end
    end
  end

  describe "#icon" do
    context "when merchant is found" do
      context "when it has an icon" do
        it "returns the merchant icon" do
          merchant = YellowPages::Merchant.new(network_id: "235251000762203")
          expect(merchant.icon).is_a? String
          expect(merchant.icon).to include("<svg")
        end
      end
      context "when without an icon" do
        it "returns nil" do
          merchant = YellowPages::Merchant.new(network_id: "1234567890")
          expect(merchant.icon).to be nil
        end
      end
    end

    context "when merchant is not found" do
      it "returns nil" do
        merchant = YellowPages::Merchant.new(network_id: "NONEXISTANT_MERCHANT_ID")
        expect(merchant.icon).to be nil
      end
    end
  end

  describe "#in_dataset?" do
    context "when not in dataset" do
      it "returns false" do
        merchant = YellowPages::Merchant.new(network_id: "NONEXISTANT_MERCHANT_ID")
        expect(merchant.in_dataset?).to be false
      end
    end

    context "when in dataset" do
      it "returns true" do
        merchant = YellowPages::Merchant.new(network_id: "1234567890")
        expect(merchant.in_dataset?).to be true
      end
    end
  end
end
