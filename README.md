# YellowPages

A hand-picked collection of the most common Merchant IDs from Stripe.

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/yellow_pages`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yellow_pages', git: 'https://github.com/hackclub/yellow_pages'
```

## Usage

```ruby
require 'yellow_pages'

YellowPages::Merchant.lookup_name(network_id: '1234567890')
#=> "Rocket Rides"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hackclub/yellow_pages.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
