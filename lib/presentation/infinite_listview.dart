import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../core/typedefs.dart';
import '../domain/pagable.dart';
import '../logic/infinite_list/infinite_list_cubit.dart';
import '../logic/page_cubit/page_cubit.dart';
import 'items/list_item.dart';
import 'widgets/item_separator.dart';
import 'widgets/placeholders/item_error_placeholder.dart';
import 'widgets/placeholders/item_placeholder.dart';
import 'widgets/placeholders/loading_placeholder.dart';

class InfiniteListView<T extends Object> extends StatefulWidget {
  const InfiniteListView({
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

class _ListView<T extends Object> extends StatelessWidget {
  const _ListView({
    required this.itemBuilder,
    this.itemPlacholderBuilder,
    this.separatorBuilder,
    this.failureBuilder,
    this.emptyBuilder,
    this.useAnimation = false,
    this.useSeparated = false,
    this.itemExtent,
    this.scrollController,
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
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfiniteListCubit<T>, InfiniteListState>(
      builder: (context, state) {
        return switch (state) {
          InitialListState() => LoadingPlaceholder(
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
          LoadingListState() => LoadingPlaceholder(
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
          LoadedListState(paged: final paged) => AnimationLimiter(
              child: RefreshIndicator(
                onRefresh: () => context.read<InfiniteListCubit<T>>().refresh(),
                child: useSeparated
                    ? separated(context, paged as Pagable<T>)
                    : builder(context, paged as Pagable<T>),
              ),
            )
        };
      },
    );
  }

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
}
