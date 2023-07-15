import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../core/typedefs.dart';
import '../../domain/pagable.dart';
import '../../logic/infinite_list/infinite_list_cubit.dart';
import '../widgets/placeholders/item_error_placeholder.dart';

@protected
abstract class BaseInfiniteSliverList<T extends Object> extends StatefulWidget {
  const BaseInfiniteSliverList({
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
  State<BaseInfiniteSliverList<T>> createState();
}

@protected
abstract class BaseListView<T extends Object> extends StatelessWidget {
  const BaseListView({
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
}

@protected
mixin InfiniteListContent<X extends Widget, T extends Object>
    on BaseListView<T> {
  Widget contentBuild(BuildContext context) {
    return BlocBuilder<InfiniteListCubit<T>, InfiniteListState>(
      builder: (context, state) {
        return switch (state) {
          // InitialListState() => LoadingPlaceholder(
          //     limit: state.limit,
          //     itemExtent: itemExtent,
          //     useSeparated: useSeparated,
          //     separatorBuilder: separatorBuilder,
          //     itemBuilder: (context, index) {
          //       return itemPlacholderBuilder?.call(
          //             context,
          //             index,
          //             page: 0,
          //             indexOnPage: index,
          //           ) ??
          //           const ItemPlaceholder();
          //     },
          //   ),
          InitialListState() => loadingPlaceholder(context, state.limit),
          ErrorListState(exception: final exception) =>
            failureBuilder?.call(context, exception: Exception('$exception')) ??
                const ItemErrorPlaceholder(),
          // LoadingListState() => LoadingPlaceholder(
          //     limit: state.limit,
          //     itemExtent: itemExtent,
          //     useSeparated: useSeparated,
          //     separatorBuilder: separatorBuilder,
          //     itemBuilder: (context, index) {
          //       return itemPlacholderBuilder?.call(
          //             context,
          //             index,
          //             page: 0,
          //             indexOnPage: index,
          //           ) ??
          //           const ItemPlaceholder();
          //     },
          //   ),
          LoadingListState() => loadingPlaceholder(context, state.limit),
          LoadedListState(paged: final paged) => useSeparated
              ? separated(context, paged as Pagable<T>)
              : builder(context, paged as Pagable<T>)
        };
      },
    );
  }

  X separated(BuildContext context, Pagable<T> paged);
  X builder(BuildContext context, Pagable<T> paged);
  Widget loadingPlaceholder(BuildContext context, int limit);
}
