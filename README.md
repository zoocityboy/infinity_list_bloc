<!-- [![ci][ci_badge]][ci_badge_link] -->

[![pub package][pub_badge]][pub_badge_link]
[![License: MIT][license_badge]][license_badge_link]
[![style: zoo lints][badge]][badge_link]
[![flutter]][flutter]
[![github_actions]][github_actions]

# Infinite ListView with Cubit

<img src="https://github.com/felangel/bloc/blob/master/docs/assets/cubit_full.png?raw=true" height=100 />

---

[![zoocityboy][logo_white]][zoocityboy_link_dark]
[![zoocityboy][logo_black]][zoocityboy_link_light]

Developed by 🦏 [zoocityboy][zoocityboy_link] with [flutter](https://flutter.dev)

---

# Infinity ListView with Cubit

is an innovative ListView package, focusing primarily on optimized loading of an infinite list without the need for callbacks, loading views, or scroll controller-based notifications.

This library is **NOT** based on [Riverpod](https://pub.dev/packages/riverpod) but on [Bloc](https://pub.dev/packages/bloc)

## The key features of this library

### Pagination-based approach

The library efficiently handles pagination by retrieving the necessary information, such as the current page, page size, total number of pages, and total count of items, from the server. This enables seamless loading of data in a paginated manner.

### Lazy loading

Data is loaded dynamically as needed, based on the visible portion of the list. The library intelligently determines which pages to fetch and displays placeholders for items until the corresponding data is loaded. Data are stored in Page Cubit outside of InfiniteListCubit

### No callbacks required

Unlike traditional approaches that rely on callbacks for data loading, flutter_optimized_infinite_list eliminates the need for callback functions. Instead, it automatically manages data retrieval and presentation, allowing for a simpler and cleaner code structure.

### Placeholder support

Each item in the list displays a placeholder until the data for its position is loaded. This provides visual feedback to users and prevents empty spaces in the list during loading.

### Easy integration

The library is designed for easy integration into Flutter applications. It provides a user-friendly API and configuration options, enabling developers to quickly implement an optimized infinite list without complex setup or additional loaders.

## Usage

To use the lints, add a dependency in your `pubspec.yaml`:

```yaml
dependencies:
  infinite_listview_bloc: ^1.0.0
```

> <kbd>ctrl/cmd</kbd> + <kbd>shift</kbd> + <kbd>p</kbd> -> Dart: Add Dependency

### How to implement

```dart
InfiniteListView<User>(
  itemBuilder: context, item, {indexOnPage, key, page}{
    return ListTile(
      key: key,
      leading: CircularAvatar(
        backgroundImage: Image.network(user.avatar)
      )
      title: Text(item.username),
      subtitle: Text(item.bio)
    )
  },
  loadNext: (page, limit) => repository.fetchPage(page, limit),
);
```

# Pagination

## Offset pagination

```bash
GET /items?limit=20&offset=100
```

## Keyset Pagination

```bash
GET /items?limit=20&created:lte:2019-01-20T00:00:00
```

## Seek Pagination

```bash
GET /items?limit=20&after_id=20
```

[analysis_options_yaml]: https://github.com/zoocityboy/zoo_lints/blob/main/analysis_options.yaml
[ci_badge]: https://github.com/zoocityboy/zoo_lints/workflows/ci/badge.svg?style=flat-square
[ci_badge_link]: https://github.com/zoocityboy/zoo_lints/actions
[badge]: https://img.shields.io/badge/style-zoo_lints-3EB489.svg
[badge_link]: https://pub.dev/packages/zoo_lints
[license_badge]: https://img.shields.io/badge/license-MIT-green.svg?style=flat-square
[license_badge_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/zoocityboy/zoo_brand/main/styles/README/zoocityboy_dark.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/zoocityboy/zoo_brand/main/styles/README/zoocityboy_light.png#gh-dark-mode-only
[zoo_lints_link]: https://github.com/zoocityboy/zoo_lints/
[pub_badge]: https://img.shields.io/pub/v/zoo_lints.svg?style=flat-square
[pub_badge_link]: https://pub.dartlang.org/packages/zoo_lints
[zoocityboy_link]: https://github.com/zoocityboy
[zoocityboy_link_dark]: https://github.com/zoocityboy#gh-dark-mode-only
[zoocityboy_link_light]: https://github.com/zoocityboy#gh-light-mode-only
[github_actions]: https://img.shields.io/badge/github%20actions-%232671E5.svg?style=flat-square&logo=githubactions&logoColor=white
[flutter]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat-square&logo=Flutter&logoColor=white
