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

Weneedfeed requires `weneedfeed.yml` that describes URLs and selectors.

### Example

```yaml
title: Example RSS feeds

pages:
  - id: example1
    title: Example 1
    description: Example feed with CSS Selector
    url: http://example.com/1
    item_selector: li
    item_description_selector: p:nth-child(3)
    item_image_selector: img
    item_link_selector: a
    item_time_selector: time
    item_title_selector: p:nth-child(2)
  - id: example2
    title: Example 2
    description: Example feed with XPath
    url: http://example.com/2
    item_selector: //li
    item_image_selector: .//img
    item_description_selector: .//p[3]
    item_link_selector: .//a
    item_time_selector: .//time
    item_title_selector: .//p[2]
```

### `title`

- optional (default: `"Weneedfeed"`)
- Used for feeds title on top page and OPML outline.

### `pages.id`

Feed ID.

- required
- Used for feed URL and `<link>` element in `<channel>` element.

### `pages.title`

Feed title.

- required
- Used for RSS `<title>` element in `<channel>` element.

### `pages.description`

Feed description.

- optional
- Used for RSS `<description>` element in `<channel>` element.

### `pages.url`

HTML source URL.

- required
- Used to fetch HTML page for building feed.

### `pages.item_selector`

CSS or XPath selector to search each item.

- required
- Equivalent unit to RSS `<item>` element.

### `pages.item_link_selector`

CSS or XPath selector to find `<a>` element in each item.

- required
- Used for `<link>` in `<item>`.

### `pages.item_title_selector`

CSS or XPath selector to find element with title information in each item.

- required
- Used for `<title>` in `<item>`.

### `pages.item_description_selector`

CSS or XPath selector to find element with description information in each item.

- optional
- Used for `<description>` in `<item>`.

### `pages.item_image_selector`

CSS or XPath selector to find `<img>`element in each item.

- optional
- Used for `<enclosure>` in `<item>`.

### `pages.item_time_selector`

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
  [--port=PORT]                # TCP port to bind to.
                               # Default: 8080

Run HTTP server.
```

## GitHub Actions Integration

Use [weneedfeed-action](https://github.com/r7kamura/weneedfeed-action) for invoking weneedfeed on GitHub Actions.
