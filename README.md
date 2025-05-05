# 📒 YellowPages

### Look up merchants from their [Stripe MID](https://stripe.com/resources/more/merchant-id)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yellow_pages', git: 'https://github.com/hackclub/yellow_pages'
```

_It is recommended to pin the version to a commit hash to ensure stability._

## Usage

```ruby
require 'yellow_pages'

merchant = YellowPages::Merchant.lookup(network_id: '1234567890')
#=> #<YellowPages::Merchant:0x0000000105dd49c8 @network_id="1234567890">
merchant.name
#=> "Rocket Rides"
```

For the latest docs (`main` branch), please
see https://yellowpages.bank.engineering/

## Configurations

At the moment, this gems only supports one configuration:

```ruby
YellowPages.missing_merchant_reporter = ->(network_id) do
  puts "Merchant with network_id #{network_id} not found"
  ErrorReporter.notify("Merchant with network_id #{network_id} not found")
end
```

| Key                         | Description                                                                                                                                                     | Default |
|-----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|---------|
| `missing_merchant_reporter` | An optional method that is called when a merchant is not found in the dataset during a lookup. Takes in one argument, the `network_id` of the missing merchant. | `nil`   |

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can
also run `bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

We're using [YARD](https://github.com/lsegal/yard) for documentation generation.
To build, run `yard`. To run the developement server, run `yard server -r`

## Contributing

Bug reports and pull requests are welcome on GitHub
at https://github.com/hackclub/yellow_pages.

### How do I add a new icon to a Merchant ID?

1. Find an existing SVG of the vendor's logo (or create one if not found), make sure this is viewable on a white and black background so it's accessible. Your SVG should be square and black with a transparent background.

2. Check [merchants.yaml](https://github.com/hackclub/yellow_pages/blob/main/lib/yellow_pages/merchants.yaml) to see if the vendor is there. If it's not, look up the merchant ID (see below) and add the merchant info to the file.

3. Upload the svg for your image to [icons](https://github.com/hackclub/yellow_pages/tree/main/lib/assets/icons) using `merchant["name"].gsub(/[ '-]/, "").downcase` as the format for the filename.

### How do I add a new Merchant?

1. Find the Merchant ID. If you don't already have it, have a look at the section below.

2. Once you have the Merchant ID, fork and open [merchants.yaml](https://github.com/hackclub/yellow_pages/blob/main/lib/yellow_pages/merchants.yaml), and at the bottom of the file add your information in this format:

```yaml
- network_ids: ["1234567890"] # Merchant IDs
  name: Rocket Rides # Merchant Name
```

Here's an example from Uber Eats:

```yaml
- network_ids: ["000445515396999", "000445473801998"]
  name: Uber Eats
```

You'll notice that in this example, there are two merchant IDs. If you've found more than one, then enter them comma seperated, wrapped in double-quotes.

#### But wait - there's already a record in merchants.yaml

Sometimes merchants use more than one MID, this is unfortunately quite common! If you come across a new one, first make sure it doesn't already exist before creating a completely new record.

Once you've found the pre-existing one, add the new one after a comma and quotation marks!

#### Merchants of Records

A Merchant of Record will share its merchant ID with multiple vendors. For example, Square will show up as the merchant for many small shops.

With our current setup, we don't want to include these in the yaml file, so if you come across one please do not try adding it.

### How do I find a Merchant ID?

1. Check [merchants.yaml](https://github.com/hackclub/yellow_pages/blob/main/lib/yellow_pages/merchants.yaml).

2. Make a transaction to the vendor using a HCB card. After making the transaction, open it and click on the Merchant drop down. From there you can click on the Merchant ID to copy it.

3. Reach out to the HCB team at hcb@hackclub.com if you were unable to locate it using Steps 1 or 2.

## License

The gem is available as open source under the terms of
the [MIT License](https://opensource.org/licenses/MIT).
