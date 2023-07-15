import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/typedefs.dart';
import '../../logic/infinite_list/infinite_list_cubit.dart';
import '../../logic/page_cubit/page_cubit.dart';
import '../widgets/placeholders/item_error_placeholder.dart';
import '../widgets/placeholders/item_placeholder.dart';

@protected
class ListItem<T extends Object> extends StatelessWidget {
  const ListItem(
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
            value: BlocProvider.of<InfiniteListCubit<T>>(context)
                .getPageCubit(page)
              ..fetch(),
            child: Builder(
              builder: (context) {
                return BlocBuilder<PageCubit<T>, PageState>(
                  builder: (context, state) {
                    return switch (state) {
                      PageInitial() => itemPlacholderBuilder?.call(
                            context,
                            index,
                            page: page,
                            indexOnPage: indexOnPage,
                          ) ??
                          const ItemPlaceholder(),
                      PageLoading() => itemPlacholderBuilder?.call(
                            context,
                            index,
                            page: page,
                            indexOnPage: indexOnPage,
                          ) ??
                          const ItemPlaceholder(),
                      PageLoaded(items: final items) => itemBuilder.call(
                          context,
                          items[indexOnPage] as T,
                          index,
                          indexOnPage: indexOnPage,
                          page: page,
                        ),
                      PageError(exception: final exception) =>
                        itemFailureBuilder?.call(
                              context,
                              exception: exception,
                            ) ??
                            const ItemErrorPlaceholder(),
                    };

                    ///
                  },
                );
              },
            ),
          );
        }
        return itemPlacholderBuilder?.call(
              context,
              index,
              page: 0,
              indexOnPage: index,
            ) ??
            const ItemPlaceholder();
      },
    );
  }
}
