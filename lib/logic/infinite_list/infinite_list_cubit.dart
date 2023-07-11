// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../core/typedefs.dart';
import '../../domain/pagable.dart';
import '../page_cubit/page_cubit.dart';

part 'infinite_list_state.dart';

class InfiniteListCubit<T extends Object> extends Cubit<InfiniteListState> {
  InfiniteListCubit(this.limit, this.loadNext) : super(const InitialListState());
  @protected
  final int limit;
  @protected
  final LoadNextCallback<T> loadNext;
  @protected
  final Map<int, PageCubit<T>> pageCubit = <int, PageCubit<T>>{};

  void initialize({int page = 0}) {
    emit(const LoadingListState());
    loadNext(page, limit).then((value) {
      for (var i = 0; i < value.totalPages; i++) {
        pageCubit[i] = PageCubit(i, limit, loadNext);
      }
      emit(LoadedListState(value));
    }).catchError((Object error) {
      if (error is Exception) {
        emit(ErrorListState(error));
      } else {
        emit(ErrorListState(Exception(error.toString())));
      }
    });
  }

  void fetchPage(int page) {
    if (!pageCubit.containsKey(page)) {
      pageCubit[page] = PageCubit(page, limit, loadNext);
    }
    pageCubit[page]!.fetch();
  }

  PageCubit<T> getPageCubit(int page) {
    return pageCubit[page]!;
  }

  Future<void> refresh() async {
    emit(const LoadingListState());
    for (final _item in pageCubit.entries) {
      await _item.value.close();
    }
    pageCubit.clear();
    try {
      final result = await loadNext(0, limit);
      for (var i = 0; i < result.totalPages; i++) {
        pageCubit[i] = PageCubit(i, limit, loadNext);
      }
      emit(LoadedListState(result));
    } catch (error) {
      if (error is Exception) {
        emit(ErrorListState(error));
      } else {
        emit(ErrorListState(Exception(error.toString())));
      }
    }
  }
}
