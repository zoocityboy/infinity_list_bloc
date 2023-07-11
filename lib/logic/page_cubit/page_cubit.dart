// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/typedefs.dart';

part 'page_state.dart';

class PageCubit<T extends Object> extends Cubit<PageState> {
  PageCubit(this.page, this.limit, this.loadNext) : super(const PageInitial());
  final int page;
  final int limit;
  LoadNextCallback<T> loadNext;

  void fetch() {
    if (state is PageInitial) {
      emit(const PageLoading());
      loadNext(page, limit).then(
        (value) {
          emit(PageLoaded(value.items));
        },
        onError: (Object error) {
          if (error is Exception) {
            emit(PageError(error));
          } else {
            emit(PageError(Exception(error.toString())));
          }
        },
      ).catchError((Object error) {
        if (error is Exception) {
          emit(PageError(error));
        } else {
          emit(PageError(Exception(error.toString())));
        }
      });
    } else {
      print('page: $page is not initial state $state');
    }
  }
}
