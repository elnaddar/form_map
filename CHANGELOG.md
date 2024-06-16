## [0.1.0] - 2024-06-16
### Added
- Introduced a new `saveBeforeValidate` parameter to the `submit` method in the `FormMap` class.
  - If `saveBeforeValidate` is true, the form state is saved before validation.
- Added documentation for public API elements to improve code readability and usability.

### Changed
- Optimized the `submit` method in the `FormMap` class to ensure null safety.
  - The function now checks if the form state is null before proceeding.
- Changed package description.

## [0.0.3] - 2024-06-15
### Added
- Added MIT license to `pubspec.yaml`.
- Changed package name typo in `README.md`.

## [0.0.2] - 2024-06-15
### Added
- Specified platform support for Android, iOS, Web, Linux, macOS, and Windows in `pubspec.yaml`.

## [0.0.1] - 2024-06-15
- Initial release with basic form mapping functionality.
