import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/typedefs.dart';
import '../infinite_listview_bloc.dart';
import '../logic/infinite_list/infinite_list_cubit.dart';
import 'items/list_item.dart';
import 'widgets/item_separator.dart';
import 'widgets/placeholders/item_error_placeholder.dart';
import 'widgets/placeholders/loading_placeholder.dart';

class InfiniteSliverList<T extends Object> extends StatefulWidget {
  const InfiniteSliverList({
    required this.itemBuilder,
    required this.loadNext,
    super.key,
    this.separatorBuilder,
    this.emptyBuilder,
    this.failureBuilder,
    this.itemPlacholderBuilder,
    this.scrollController,
    this.limit = 10,
    this.useAnimation = false,
    this.useSeparated = false,
    this.itemExtent,
  });
  final EmptyBuilder? emptyBuilder;
  final FailureBuilder? failureBuilder;
  final ItemBuilder<T> itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final PagedBuilder? itemPlacholderBuilder;
  final LoadNextCallback<T> loadNext;
  final ScrollController? scrollController;
  final int limit;
  final bool useAnimation;
  final double? itemExtent;
  final bool useSeparated;

  @override
  State<InfiniteSliverList<T>> createState() => _InfiniteSliverListState<T>();
}

class _InfiniteSliverListState<T extends Object>
    extends State<InfiniteSliverList<T>> {
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

class _SliveList<T extends Object> extends StatelessWidget {
  const _SliveList({
    required this.itemBuilder,
    this.itemPlacholderBuilder,
    this.separatorBuilder,
    this.failureBuilder,
    this.emptyBuilder,
    this.useAnimation = false,
    this.useSeparated = false,
    this.itemExtent,
    super.key,
  });
  final ItemBuilder<T> itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final PagedBuilder? itemPlacholderBuilder;
  final FailureBuilder? failureBuilder;
  final EmptyBuilder? emptyBuilder;
  final bool useAnimation;
  final bool useSeparated;
  final double? itemExtent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfiniteListCubit<T>, InfiniteListState>(
      builder: (context, state) {
        return switch (state) {
          InitialListState() => SliverLoadingPlaceholder(
              limit: state.limit,
              itemExtent: itemExtent,
              useSeparated: useSeparated,
              separatorBuilder: separatorBuilder,
              itemBuilder: (context, index) {
                return itemPlacholderBuilder?.call(
                      context,
                      index,
                      page: 0,
                      indexOnPage: index,
                    ) ??
                    const ItemPlaceholder();
              },
            ),
          ErrorListState(exception: final exception) =>
            failureBuilder?.call(context, exception: Exception('$exception')) ??
                const ItemErrorPlaceholder(),
          LoadingListState() => SliverLoadingPlaceholder(
              limit: state.limit,
              itemExtent: itemExtent,
              useSeparated: useSeparated,
              separatorBuilder: separatorBuilder,
              itemBuilder: (context, index) {
                return itemPlacholderBuilder?.call(
                      context,
                      index,
                      page: 0,
                      indexOnPage: index,
                    ) ??
                    const ItemPlaceholder();
              },
            ),
          LoadedListState(paged: final paged) => useSeparated
              ? separated(context, paged as Pagable<T>)
              : builder(context, paged as Pagable<T>)
        };
      },
    );
  }

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
}
