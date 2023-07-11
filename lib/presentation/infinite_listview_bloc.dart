import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../core/typedefs.dart';
import '../logic/infinite_list/infinite_list_cubit.dart';
import '../logic/page_cubit/page_cubit.dart';
import 'widgets/item_error_placeholder.dart';
import 'widgets/item_placeholder.dart';
import 'widgets/loading_placeholder.dart';

class InfiniteListView<T extends Object> extends StatefulWidget {
  const InfiniteListView({
    required this.itemBuilder,
    required this.loadNext,
    super.key,
    this.emptyBuilder,
    this.failureBuilder,
    this.itemPlacholderBuilder,
    this.scrollController,
    this.limit = 10,
    this.useAnimation = false,
    this.itemExtent,
  });
  final EmptyBuilder? emptyBuilder;
  final FailureBuilder? failureBuilder;
  final ItemBuilder<T> itemBuilder;
  final PagedBuilder? itemPlacholderBuilder;
  final LoadNextCallback<T> loadNext;
  final ScrollController? scrollController;
  final int limit;
  final bool useAnimation;
  final double? itemExtent;

  @override
  State<InfiniteListView<T>> createState() => _InfiniteListViewState<T>();
}

class _InfiniteListViewState<T extends Object> extends State<InfiniteListView<T>> {
  late final ItemBuilder<T> itemBuilder = widget.itemBuilder;
  late final PagedBuilder<T>? itemPlacholderBuilder = widget.itemPlacholderBuilder;
  late final bool useAnimation = widget.useAnimation;
  late final ScrollController? scrollController = widget.scrollController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfiniteListCubit(widget.limit, widget.loadNext)..initialize(),
      child: _ListView(
        scrollController: scrollController,
        itemBuilder: itemBuilder,
        itemPlacholderBuilder: itemPlacholderBuilder,
        useAnimation: useAnimation,
        itemExtent: widget.itemExtent,
      ),
    );
  }
}

class _ListView<T extends Object> extends StatelessWidget {
  const _ListView({
    required this.itemBuilder,
    this.itemPlacholderBuilder,
    this.failureBuilder,
    this.emptyBuilder,
    this.useAnimation = false,
    this.itemExtent,
    this.scrollController,
    super.key,
  });
  final ItemBuilder<T> itemBuilder;
  final PagedBuilder? itemPlacholderBuilder;
  final FailureBuilder? failureBuilder;
  final EmptyBuilder? emptyBuilder;
  final bool useAnimation;
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
              itemBuilder: (context, index) {
                return itemPlacholderBuilder?.call(context, page: 0, indexOnPage: index) ?? const ItemPlaceholder();
              },
            ),
          ErrorListState(exception: final exception) =>
            failureBuilder?.call(context, exception: Exception('$exception')) ?? const ItemErrorPlaceholder(),
          LoadingListState() => LoadingPlaceholder(
              limit: state.limit,
              itemExtent: itemExtent,
              itemBuilder: (context, index) {
                return itemPlacholderBuilder?.call(context, page: 0, indexOnPage: index) ?? const ItemPlaceholder();
              },
            ),
          LoadedListState(paged: final paged) => AnimationLimiter(
              child: RefreshIndicator(
                onRefresh: () => context.read<InfiniteListCubit<T>>().refresh(),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: paged.totalCount,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemExtent: itemExtent,
                  itemBuilder: (_, index) {
                    return _ListItem(index, itemBuilder: itemBuilder, itemPlacholderBuilder: itemPlacholderBuilder);
                  },
                ),
              ),
            )
        };
      },
    );
  }
}

class _ListItem<T extends Object> extends StatelessWidget {
  const _ListItem(
    this.index, {
    required this.itemBuilder,
    this.itemPlacholderBuilder,
    this.itemFailureBuilder,
    super.key,
  });
  final ItemBuilder<T> itemBuilder;
  final PagedBuilder<T>? itemPlacholderBuilder;
  final FailureBuilder? itemFailureBuilder;

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfiniteListCubit<T>, InfiniteListState>(
      builder: (context, state) {
        final page = index ~/ state.limit;
        final indexOnPage = index % state.limit;
        if (state is LoadedListState) {
          return BlocProvider.value(
            value: BlocProvider.of<InfiniteListCubit<T>>(context).getPageCubit(page)..fetch(),
            child: Builder(
              builder: (context) {
                return BlocBuilder<PageCubit<T>, PageState>(
                  builder: (context, state) {
                    return switch (state) {
                      PageInitial() => itemPlacholderBuilder?.call(context, page: page, indexOnPage: indexOnPage) ??
                          const ItemPlaceholder(),
                      PageLoading() => itemPlacholderBuilder?.call(context, page: page, indexOnPage: indexOnPage) ??
                          const ItemPlaceholder(),
                      PageLoaded(items: final items) => itemBuilder.call(
                          context,
                          items[indexOnPage] as T,
                          indexOnPage: indexOnPage,
                          page: page,
                        ),
                      PageError(exception: final exception) =>
                        itemFailureBuilder?.call(context, exception: exception) ?? const ItemErrorPlaceholder(),
                    };

                    ///
                  },
                );
              },
            ),
          );
        }
        return itemPlacholderBuilder?.call(context, page: 0, indexOnPage: index) ?? const ItemPlaceholder();
      },
    );
  }
}
