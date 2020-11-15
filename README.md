# Weneedfeed

[![](https://badge.fury.io/rb/weneedfeed.svg)](https://rubygems.org/gems/weneedfeed)
[![](https://github.com/r7kamura/weneedfeed/workflows/test/badge.svg)](https://github.com/r7kamura/weneedfeed/actions?query=workflow%3Atest)

Generate feeds from URL and selectors.

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

## Schema

You need to write a schema file named with `weneedfeed.yml` to use this gem.

### Example

```yaml
pages:
  - id: example1
    title: example site 1
    url: http://example.com/1
    item_selector: li
    item_description_selector: p:nth-child(3)
    item_link_selector: a
    item_time_selector: time
    item_title_selector: p:nth-child(2)
  - id: example2
    title: example site 2
    url: http://example.com/2
    item_selector: //li
    item_description_selector: .//p[3]
    item_link_selector: .//a
    item_time_selector: .//time
    item_title_selector: .//p[2]
```

### `id`

Feed ID.

- required
- Used for feed URL.

### `title`

Feed title.

- required
- Used for RSS `<title>` element in `<channel>` element.

### `url`

HTML source URL.

- required
- Used to fetch HTML page for building feed.

### `item_selector`

CSS or XPath selector to search each item.

- required
- Equivalent unit to RSS `<item>` element.

### `item_link_selector`

CSS or XPath selector to find `<a>` element in each item.

- required
- Used for `<link>` in `<item>`.

### `item_title_selector`

CSS or XPath selector to find element with title information in each item.

- required
- Used for `<title>` in `<item>`.

### `item_description_selector`

CSS or XPath selector to find element with description information in each item.

- optional
- Used for `<description>` in `<item>`.

### `item_time_selector`

CSS or XPath selector to find element with datetime information in each item.

- optional
- Used for `<pubDate>` in `<item>`. Its `datetime` attribute or its inner HTML is used to calculate datetime.

## Usage

### Build

Run `weneedfeed build` to build static files.

```
Usage:
  weneedfeed build --base-url=BASE_URL

Options:
  --base-url=BASE_URL          # Base URL where to locate built files. (e.g. `"https://user.github.io/repo"`)
  [--schema-path=SCHEMA_PATH]  # Path to weneedfeed YAML schema file.
                               # Default: weneedfeed.yml

Build static files.
```

### Server

Run `weneedfeed server` to run HTTP server.

```
Usage:
  weneedfeed server

Options:
  [--schema-path=SCHEMA_PATH]  # Path to weneedfeed YAML schema file.
                               # Default: weneedfeed.yml

Run HTTP server.
```

## GitHub Actions Integration

Use [weneedfeed-action](https://github.com/r7kamura/weneedfeed-action) for invoking weneedfeed on GitHub Actions.

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
