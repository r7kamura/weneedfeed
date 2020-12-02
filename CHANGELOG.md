# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## 0.9.2

### Fixed

- Fix item image URL on JSON source.
- Fix item image MIME type detection.

## 0.9.1 - 2020-12-03

### Fixed

- Fix escape bug in escaping HTML and generating XML.

## 0.9.0 - 2020-12-03

### Added

- Add item_image_selector.

## 0.8.0 - 2020-11-25

### Added

- Add page description for writing channel description.

### Changed

- Change channel link content from feeds index URL to page URL.

## 0.7.2 - 2020-11-25

### Fixed

- Fix time parse error by HTML entities handling.

## 0.7.1 - 2020-11-25

### Fixed

- Fix error when no title element found.

## 0.7.0 - 2020-11-23

### Added

- Convert JSON response into XML.

### Fixed

- Fix bug that item_description_selector is not used.

## 0.6.1 - 2020-11-15

### Changed

- Require hibana 0.2 or later.

### Fixed

- Fix installation error caused by hanami-router version restriction.

### Removed

- Remove direct dependency on hanami-router.

## 0.6.0 - 2020-11-15

### Changed

- Change pages schema from Hash to Array.
- Require hanami-router 2.0.0.alpha3 or later versions.
- Ignore pubDate when item.time is not found.
- Make some item_description_selector and item_time_selector optional.

## 0.5.0 - 2020-11-14

### Added

- Add datetime attribute support on time element.

### Changed

- Change schema format about selectors.

## 0.4.1 - 2020-11-08

### Fixed

- Fix error when item description is not found.

## 0.4.0 - 2020-11-08

### Added

- Add CSS selector support.

### Changed

- Change schema key from `xpath` to `selectors`.
- Change item_link_selector target from href attribute to a element.
- Change some argument names from `_xpath` to `_selector`.
- Change `weneedfeed build` description.
- Change `weneedfeed server` description.
- Change channel link from feed URL to top page URL.
- Sort top page feeds by its title.

## 0.3.0 - 2020-11-08

### Added

- Add channel description.
- Add item description.
- Add `weneedfeed build` command.
- Add `weneedfeed server` command.

### Changed

- Surround channel title by CDATA.
- Change channel children order.

## 0.2.0 - 2020-11-07

### Changed

- Change required ruby version from 2.4.0 to 2.5.0.

### Fixed

- Fix feed URL when SCRIPT_NAME is used.

## 0.1.0 - 2020-10-29

### Added

- 1st release.
