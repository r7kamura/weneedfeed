# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

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
