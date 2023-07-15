import 'package:flutter/material.dart';

import '../../../infinite_listview_bloc.dart';
import '../item_separator.dart';

class LoadingListPlaceholder<T extends Object> extends StatelessWidget {
  const LoadingListPlaceholder({
    required this.limit,
    super.key,
    this.itemBuilder,
    this.separatorBuilder,
    this.itemExtent,
    this.useSeparated = false,
  });
  final IndexedWidgetBuilder? itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final int limit;
  final double? itemExtent;
  final bool useSeparated;
  @override
  Widget build(BuildContext context) => builder(context);

  Widget builder(BuildContext context) {
    if (useSeparated) {
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) =>
            separatorBuilder?.call(
              context,
              index,
            ) ??
            const ItemSeparator(),
        itemBuilder: itemBuilder ??
            (context, index) {
              return const ItemPlaceholder();
            },
        itemCount: limit,
      );
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemExtent: itemExtent,
      itemBuilder: itemBuilder ??
          (context, index) {
            return const ItemPlaceholder();
          },
      itemCount: limit,
    );
  }
}

class SliverLoadingPlaceholder<T extends Object> extends StatelessWidget {
  const SliverLoadingPlaceholder({
    required this.limit,
    super.key,
    this.itemBuilder,
    this.separatorBuilder,
    this.itemExtent,
    this.useSeparated = false,
  });
  final IndexedWidgetBuilder? itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final int limit;
  final double? itemExtent;
  final bool useSeparated;
  @override
  Widget build(BuildContext context) => builder(context);

  Widget builder(BuildContext context) {
    if (useSeparated) {
      return SliverList.separated(
        separatorBuilder: (context, index) =>
            separatorBuilder?.call(
              context,
              index,
            ) ??
            const ItemSeparator(),
        itemBuilder: itemBuilder ??
            (context, index) {
              return SizedBox(
                height: itemExtent,
                child: const ItemPlaceholder(),
              );
            },
        itemCount: limit,
      );
    }
    return SliverList.builder(
      itemBuilder: itemBuilder ??
          (context, index) {
            return SizedBox(
              height: itemExtent,
              child: const ItemPlaceholder(),
            );
          },
      itemCount: limit,
    );
  }
}
