# 📒 YellowPages

### Look up merchants from their [Stripe MID](https://stripe.com/resources/more/merchant-id)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yellow_pages', git: 'https://github.com/hackclub/yellow_pages'
```

## Usage

```ruby
require 'yellow_pages'

merchant = YellowPages::Merchant.lookup(network_id: '1234567890')
#=> #<YellowPages::Merchant:0x0000000105dd49c8 @network_id="1234567890">
merchant.name
#=> "Rocket Rides"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

We're using [YARD](https://github.com/lsegal/yard) for documentation generation. To build, run `yard`. To run the developement server, run `yard server -r`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hackclub/yellow_pages.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
