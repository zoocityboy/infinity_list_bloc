import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/typedefs.dart';
import '../infinite_listview_bloc.dart';
import '../logic/infinite_list/infinite_list_cubit.dart';
import 'base/infinite_base_grid.dart';
import 'items/list_item.dart';
import 'widgets/placeholders/loading_grid_placeholder.dart';

class InfiniteSliverGrid<T extends Object> extends BaseInfiniteSliverGrid<T> {
  const InfiniteSliverGrid({
    required super.itemBuilder,
    required super.loadNext,
    required super.gridDelegate,
    super.key,
    super.emptyBuilder,
    super.failureBuilder,
    super.itemPlacholderBuilder,
    super.scrollController,
    super.limit = 10,
    super.useAnimation = false,
  });

  @override
  State<InfiniteSliverGrid<T>> createState() => _InfiniteSliverGridState<T>();
}

class _InfiniteSliverGridState<T extends Object>
    extends State<InfiniteSliverGrid<T>> {
  late final ItemBuilder<T> itemBuilder = widget.itemBuilder;
  late final PagedBuilder<T>? itemPlacholderBuilder =
      widget.itemPlacholderBuilder;
  late final bool useAnimation = widget.useAnimation;
  late final ScrollController? scrollController = widget.scrollController;

  late final SliverGridDelegate gridDelegate = widget.gridDelegate;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InfiniteListCubit(widget.limit, widget.loadNext)..initialize(),
      child: _SliveGrid(
        itemBuilder: itemBuilder,
        itemPlacholderBuilder: itemPlacholderBuilder,
        useAnimation: useAnimation,
        gridDelegate: gridDelegate,
      ),
    );
  }
}

class _SliveGrid<T extends Object> extends BaseGridView<T>
    with InfiniteGridContent<SliverGrid, T> {
  const _SliveGrid({
    required super.itemBuilder,
    required super.gridDelegate,
    super.emptyBuilder,
    super.failureBuilder,
    super.itemPlacholderBuilder,
    super.key,
    super.scrollController,
    super.useAnimation,
  });

  @override
  Widget build(BuildContext context) => contentBuild(context);

  @override
  SliverGrid builder(BuildContext context, Pagable<T> paged) =>
      SliverGrid.builder(
        gridDelegate: gridDelegate,
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
  Widget loadingPlaceholder(BuildContext context, int limit) {
    return SliverGridLoadingPlaceholder(
      gridDelegate: gridDelegate,
      limit: limit,
      itemBuilder: (context, index) =>
          itemPlacholderBuilder?.call(
            context,
            index,
            page: 0,
            indexOnPage: index,
          ) ??
          const ItemGridPlaceholder(),
    );
  }
}
