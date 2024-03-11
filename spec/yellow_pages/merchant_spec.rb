
RSpec.describe YellowPages::Merchant do
  it "exists" do
    expect(YellowPages::Merchant).not_to be nil
  end

  it "has a lookup method" do
    expect(YellowPages::Merchant).to respond_to(:lookup)
  end
end