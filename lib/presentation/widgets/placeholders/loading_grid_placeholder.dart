import 'package:flutter/material.dart';

import '../item_separator.dart';
import 'item_placeholder.dart';

class LoadingGridPlaceholder<T extends Object> extends StatelessWidget {
  const LoadingGridPlaceholder({
    required this.limit,
    required this.gridDelegate,
    super.key,
    this.itemBuilder,
    this.separatorBuilder,
    this.itemExtent,
  });
  final IndexedWidgetBuilder? itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final int limit;
  final double? itemExtent;
  final SliverGridDelegate gridDelegate;
  @override
  Widget build(BuildContext context) => builder(context);

  Widget builder(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: gridDelegate,
      itemBuilder: itemBuilder ??
          (context, index) {
            return const ItemGridPlaceholder();
          },
      itemCount: limit,
    );
  }
}

class SliverGridLoadingPlaceholder<T extends Object> extends StatelessWidget {
  const SliverGridLoadingPlaceholder({
    required this.gridDelegate,
    required this.limit,
    super.key,
    this.itemBuilder,
  });
  final IndexedWidgetBuilder? itemBuilder;
  final int limit;
  final SliverGridDelegate gridDelegate;
  @override
  Widget build(BuildContext context) => builder(context);

  Widget builder(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: gridDelegate,
      itemBuilder: itemBuilder ??
          (context, index) {
            return const ItemGridPlaceholder();
          },
      itemCount: limit,
    );
  }
}

class ItemGridPlaceholder extends StatelessWidget {
  const ItemGridPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: SizedBox.expand(),
    );
  }
}
