# Read category.yaml

require "yaml"
require "pathname"

module YellowPages
  class Category
    # @return [Hash] all categories keyed by their MCC code
    def self.categories_by_code
      @categories_by_code ||=
        begin
          path = Pathname.new(__dir__).join("categories.yaml")
          YAML.load_file(path).map do |code, obj|
            [code, obj.merge(code:).transform_keys(&:to_sym)]
          end.to_h
        end
    end

    # @return [Hash] all categories keyed by their stripe key
    def self.categories_by_key
      @categories_by_key ||=
        begin
          categories_by_code.map do |code, obj|
            [obj.fetch(:key), obj]
          end.to_h
        end
    end

    # Pre-compile on boot/gem require
    categories_by_code
    categories_by_key

    def initialize(code: nil, key: nil)
      raise ArugmentError, "Either code or key must be provided" if code.nil? && key.nil?

      @code, @key = code, key
    end

    def self.lookup(...)
      new(...)
    end

    # Returns category's code
    #
    # @return [String, nil] the code of the category, if found
    def code
      category&.fetch(:code)
    end

    # Returns category's name
    #
    # @return [String, nil] the name of the category, if found
    def name
      category&.fetch(:name)
    end

    # Returns category's key
    #
    # @return [String, nil] the key of the category, if found
    def key
      category&.fetch(:key)
    end

    # Returns true if the category is in the dataset
    # @return [Boolean] whether the category is in our dataset
    def in_dataset?
      !category.nil?
    end

    private

    def category
      if @code.nil?
        self.class.categories_by_key[@key]
      else
        self.class.categories_by_code[@code]
      end
    end
  end
end
