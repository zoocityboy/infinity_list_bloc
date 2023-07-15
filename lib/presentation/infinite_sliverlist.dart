import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/typedefs.dart';
import '../infinite_listview_bloc.dart';
import '../logic/infinite_list/infinite_list_cubit.dart';
import 'base/infinite_base_list.dart';
import 'items/list_item.dart';
import 'widgets/item_separator.dart';
import 'widgets/placeholders/loading_placeholder.dart';

class InfiniteSliverList<T extends Object> extends BaseInfiniteSliverList<T> {
  const InfiniteSliverList({
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
  State<InfiniteSliverList<T>> createState() => _InfiniteSliverListState<T>();
}

class _InfiniteSliverListState<T extends Object>
    extends State<InfiniteSliverList<T>> {
  late final ItemBuilder<T> itemBuilder;
  late final PagedBuilder<T>? itemPlacholderBuilder;
  late final IndexedWidgetBuilder? separatorBuilder;
  late final bool useAnimation;
  late final bool useSeparated;
  late final ScrollController? scrollController;
  late final double? itemExtent;
  late final int limit;
  late final LoadNextCallback<T> loadNext;
  @override
  void initState() {
    limit = widget.limit;
    loadNext = widget.loadNext;
    itemBuilder = widget.itemBuilder;
    itemPlacholderBuilder = widget.itemPlacholderBuilder;
    separatorBuilder = widget.separatorBuilder;
    useAnimation = widget.useAnimation;
    useSeparated = widget.useSeparated;
    scrollController = widget.scrollController;
    itemExtent = widget.itemExtent;

    super.initState();
  }
  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InfiniteListCubit(limit, loadNext)..initialize(),
      child: _SliveList(
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

class _SliveList<T extends Object> extends BaseListView<T>
    with InfiniteListContent<SliverList, T> {
  const _SliveList({
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
  SliverList separated(BuildContext context, Pagable<T> paged) =>
      SliverList.separated(
        itemCount: paged.totalCount,
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
  SliverList builder(BuildContext context, Pagable<T> paged) =>
      SliverList.builder(
        itemCount: paged.totalCount,
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
    return SliverLoadingPlaceholder<T>(
      limit: limit,
      itemBuilder: (context, index) => const ItemPlaceholder(),
      separatorBuilder: separatorBuilder,
      itemExtent: itemExtent,
      useSeparated: useSeparated,
    );
  }
}
