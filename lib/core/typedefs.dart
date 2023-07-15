import 'package:flutter/widgets.dart';

import '../domain/pagable.dart';

/// Call new request for fetch data
typedef LoadNextCallback<T> = Future<Pagable<T>> Function(int page, int limit);

/// Item builder for row in InfiniteListView with extra [T] item attribute
typedef ItemBuilder<T extends Object> = Widget Function(
  BuildContext context,
  T item,
  int index, {
  Key? key,
  int? page,
  int? indexOnPage,
});
typedef SeparatorBuilder<T extends Object> = Widget Function(
  BuildContext context,
  int index,
);
typedef PagedBuilder<T extends Object> = Widget Function(
  BuildContext context,
  int index, {
  Key? key,
  int? page,
  int? indexOnPage,
});

/// Failure builder for InfiniteListView with [Exception] attribute
typedef FailureBuilder<T extends Object> = Widget Function(
  BuildContext context, {
  required Exception exception,
});

/// Empty builder for InfiniteListView with optional [title] and [description] attribute
typedef EmptyBuilder<T extends Object> = Widget Function(
  BuildContext context, {
  String? title,
  String? description,
});

/// Callback for Show/Hide scroll top
typedef ScrollTopCallback = void Function(bool show);
