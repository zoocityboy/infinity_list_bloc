import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/typedefs.dart';
import '../domain/pagable.dart';
import '../logic/infinite_list/infinite_list_cubit.dart';
import 'base/infinite_base_list.dart';
import 'items/list_item.dart';
import 'widgets/item_separator.dart';
import 'widgets/placeholders/item_placeholder.dart';
import 'widgets/placeholders/loading_placeholder.dart';

class InfiniteListView<T extends Object> extends BaseInfiniteSliverList<T> {
  const InfiniteListView({
    required super.itemBuilder,
    required super.loadNext,
    super.key,
    super.separatorBuilder,
    super.emptyBuilder,
    super.failureBuilder,
    super.itemPlacholderBuilder,
    super.scrollController,
    super.limit = 10,
    super.useAnimation = false,
    super.useSeparated = false,
    super.itemExtent,
  });
  @override
  State<InfiniteListView<T>> createState() => _InfiniteListViewState<T>();
}

class _InfiniteListViewState<T extends Object>
    extends State<InfiniteListView<T>> {
  late final ItemBuilder<T> itemBuilder = widget.itemBuilder;
  late final PagedBuilder<T>? itemPlacholderBuilder =
      widget.itemPlacholderBuilder;
  late final IndexedWidgetBuilder? separatorBuilder = widget.separatorBuilder;
  late final bool useAnimation = widget.useAnimation;
  late final bool useSeparated = widget.useSeparated;
  late final ScrollController? scrollController = widget.scrollController;
  late final double? itemExtent = widget.itemExtent;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InfiniteListCubit(widget.limit, widget.loadNext)..initialize(),
      child: _ListView(
        scrollController: scrollController,
        itemBuilder: itemBuilder,
        separatorBuilder: separatorBuilder,
        itemPlacholderBuilder: itemPlacholderBuilder,
        useAnimation: useAnimation,
        useSeparated: useSeparated,
        itemExtent: itemExtent,
      ),
    );
  }
}

class _ListView<T extends Object> extends BaseListView<T>
    with InfiniteListContent<ListView, T> {
  const _ListView({
    required super.itemBuilder,
    super.emptyBuilder,
    super.failureBuilder,
    super.itemExtent,
    super.itemPlacholderBuilder,
    super.key,
    super.scrollController,
    super.separatorBuilder,
    super.useAnimation,
    super.useSeparated,
  });

  @override
  Widget build(BuildContext context) => contentBuild(context);

  @override
  ListView separated(BuildContext context, Pagable<T> paged) =>
      ListView.separated(
        controller: scrollController,
        itemCount: paged.totalCount,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (context, index) =>
            separatorBuilder?.call(
              context,
              index,
            ) ??
            const ItemSeparator(),
        itemBuilder: (_, index) {
          return ListItem(
            index,
            itemBuilder: itemBuilder,
            itemPlacholderBuilder: itemPlacholderBuilder,
          );
        },
      );
  @override
  ListView builder(BuildContext context, Pagable<T> paged) => ListView.builder(
        controller: scrollController,
        itemCount: paged.totalCount,
        physics: const AlwaysScrollableScrollPhysics(),
        itemExtent: itemExtent,
        itemBuilder: (_, index) {
          return ListItem(
            index,
            itemBuilder: itemBuilder,
            itemPlacholderBuilder: itemPlacholderBuilder,
          );
        },
      );

  @override
  Widget loadingPlaceholder(
    BuildContext context,
    int limit,
  ) {
    return LoadingListPlaceholder(
      limit: limit,
      itemBuilder: (context, index) => const ItemPlaceholder(),
      separatorBuilder: separatorBuilder,
      itemExtent: itemExtent,
      useSeparated: useSeparated,
    );
  }
}
