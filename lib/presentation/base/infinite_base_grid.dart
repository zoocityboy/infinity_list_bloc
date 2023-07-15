import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/typedefs.dart';
import '../../domain/pagable.dart';
import '../../logic/infinite_list/infinite_list_cubit.dart';
import '../widgets/placeholders/item_error_placeholder.dart';

@protected
abstract class BaseInfiniteSliverGrid<T extends Object> extends StatefulWidget {
  const BaseInfiniteSliverGrid({
    required this.itemBuilder,
    required this.loadNext,
    required this.gridDelegate,
    super.key,
    this.emptyBuilder,
    this.failureBuilder,
    this.itemPlacholderBuilder,
    this.scrollController,
    this.limit = 10,
    this.useAnimation = false,
  });

  final EmptyBuilder? emptyBuilder;
  final FailureBuilder? failureBuilder;
  final ItemBuilder<T> itemBuilder;

  final PagedBuilder? itemPlacholderBuilder;
  final LoadNextCallback<T> loadNext;
  final ScrollController? scrollController;
  final int limit;
  final bool useAnimation;
  final SliverGridDelegate gridDelegate;

  @override
  State<BaseInfiniteSliverGrid<T>> createState();
}

@protected
abstract class BaseGridView<T extends Object> extends StatelessWidget {
  const BaseGridView({
    required this.itemBuilder,
    required this.gridDelegate,
    this.itemPlacholderBuilder,
    this.separatorBuilder,
    this.failureBuilder,
    this.emptyBuilder,
    this.useAnimation = false,
    this.scrollController,
    super.key,
  });
  final SliverGridDelegate gridDelegate;
  final ItemBuilder<T> itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final PagedBuilder? itemPlacholderBuilder;
  final FailureBuilder? failureBuilder;
  final EmptyBuilder? emptyBuilder;
  final bool useAnimation;
  final ScrollController? scrollController;
}

@protected
mixin InfiniteGridContent<S extends Widget, T extends Object>
    on BaseGridView<T> {
  Widget contentBuild(BuildContext context) {
    return BlocBuilder<InfiniteListCubit<T>, InfiniteListState>(
      builder: (context, state) {
        return switch (state) {
          InitialListState() => loadingPlaceholder(context, state.limit),
          ErrorListState(exception: final exception) =>
            failureBuilder?.call(context, exception: Exception('$exception')) ??
                const ItemErrorPlaceholder(),
          LoadingListState() => loadingPlaceholder(context, state.limit),
          LoadedListState(paged: final paged) =>
            builder(context, paged as Pagable<T>)
        };
      },
    );
  }

  S builder(BuildContext context, Pagable<T> paged);
  Widget loadingPlaceholder(BuildContext context, int limit);
}
