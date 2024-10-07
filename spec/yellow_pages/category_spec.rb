RSpec.describe YellowPages::Category do
  it "exists" do
    expect(YellowPages::Category).not_to be nil
  end

  describe "::lookup" do
    it "initializes a new category by MCC" do
      category = YellowPages::Category.lookup(code: 5598)
      expect(category).to be_a YellowPages::Category
    end
    it "initializes a new category by Stripe code" do
      category = YellowPages::Category.lookup(key: "government_licensed_horse_dog_racing_us_region_only")
      expect(category).to be_a YellowPages::Category
    end
    it "throws an error if neither a key nor a code is provided" do
      expect {
        YellowPages::Category.lookup(key: nil, code: nil)
      }.to raise_error(ArgumentError)
    end
  end

  describe "::categories_by_code" do
    it "returns a hash of categories keyed by their MCC codes" do
      categories = YellowPages::Category.categories_by_code
      expect(categories).to be_a Hash
      expect(categories.keys).to include(8699)
      expect(categories[8699].keys).to include(:key, :name)
    end
  end

  describe "::categories_by_key" do
    it "returns a hash of categories keyed by their Stripe names" do
      categories = YellowPages::Category.categories_by_key
      expect(categories).to be_a Hash
      expect(categories.keys).to include("telegraph_services")
      expect(categories["telegraph_services"].keys).to include(:key, :name)
    end
  end

  describe "#name" do
    context "when category is found" do
      it "returns the category's name" do
        category = YellowPages::Category.new(key: "typewriter_stores")
        expect(category.name).to eq("Typewriter Stores")
      end
    end

    context "when category is not found" do
      it "returns nil" do
        category = YellowPages::Category.new(key: "illicit_goods_and_activities")
        expect(category.name).to be nil

        category = YellowPages::Category.new(key: "")
        expect(category.name).to be nil
      end
    end
  end

  describe "#key" do
    context "when category is found" do
      it "returns the category's key" do
        category = YellowPages::Category.new(code: 5681)
        expect(category.key).to eq("furriers_and_fur_shops")
      end
    end

    context "when category is not found" do
      it "returns nil" do
        category = YellowPages::Category.new(code: 42069)
        expect(category.key).to be nil
      end
    end
  end

  describe "#in_dataset?" do
    context "when not in dataset" do
      it "returns false" do
        category = YellowPages::Category.new(code: 31337)
        expect(category.in_dataset?).to be false

        category = YellowPages::Category.new(key: "horse_annihilation_services")
        expect(category.in_dataset?).to be false
      end
    end

    context "when in dataset" do
      it "returns true" do
        category = YellowPages::Category.new(code: 7251)
        expect(category.in_dataset?).to be true

        category = YellowPages::Category.new(key: "video_tape_rental_stores")
        expect(category.in_dataset?).to be true
      end
    end
  end
end
