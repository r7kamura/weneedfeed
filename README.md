# Weneedfeed

[![](https://badge.fury.io/rb/weneedfeed.svg)](https://rubygems.org/gems/weneedfeed)
[![](https://github.com/r7kamura/weneedfeed/workflows/test/badge.svg)](https://github.com/r7kamura/weneedfeed/actions?query=workflow%3Atest)

Generate feeds from URL and XPath.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'weneedfeed'
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install weneedfeed
```

## Usage

Write schema:

```yaml
pages:
  example:
    title: example name
    url: http://example.com/
    xpath:
      item: //li
      item_description: .//p[3]
      item_link: .//a/@href
      item_time: .//time/@datetime
      item_title: .//p[2]
```

And then call `Weneedfeed::Capture`:

```ruby
require 'weneedfeed'

Weneedfeed::Capture.call(
  base_url: 'https://user.github.io/repo',
  schema_path: 'schema.yml'
)
```

These files will be generated:

- output/index.html
- output/feeds/example.xml

## Development

### Setup

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Local installation

To install this gem onto your local machine, run `bundle exec rake install`.

### Release

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/r7kamura/weneedfeed.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
