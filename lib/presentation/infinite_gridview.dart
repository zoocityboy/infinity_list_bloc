import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/typedefs.dart';
import '../domain/pagable.dart';
import '../logic/infinite_list/infinite_list_cubit.dart';
import 'base/infinite_base_grid.dart';
import 'items/list_item.dart';
import 'widgets/placeholders/loading_grid_placeholder.dart';

class InfiniteGridView<T extends Object> extends BaseInfiniteSliverGrid<T> {
  const InfiniteGridView({
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
  State<InfiniteGridView<T>> createState() => _InfiniteGridViewState<T>();
}

class _InfiniteGridViewState<T extends Object>
    extends State<InfiniteGridView<T>> {
  late final ItemBuilder<T> itemBuilder = widget.itemBuilder;
  late final PagedBuilder<T>? itemPlacholderBuilder =
      widget.itemPlacholderBuilder;
  late final bool useAnimation = widget.useAnimation;
  late final bool useSeparated = false;
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
      child: _GridView(
        scrollController: scrollController,
        itemBuilder: itemBuilder,
        itemPlacholderBuilder: itemPlacholderBuilder,
        useAnimation: useAnimation,
        gridDelegate: gridDelegate,
      ),
    );
  }
}

class _GridView<T extends Object> extends BaseGridView<T>
    with InfiniteGridContent<GridView, T> {
  const _GridView({
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
  GridView builder(BuildContext context, Pagable<T> paged) => GridView.builder(
        controller: scrollController,
        itemCount: paged.totalCount,
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: gridDelegate,
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
    return LoadingGridPlaceholder(
      limit: limit,
      gridDelegate: gridDelegate,
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
