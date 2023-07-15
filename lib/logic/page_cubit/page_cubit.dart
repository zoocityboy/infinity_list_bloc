// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/typedefs.dart';

part 'page_state.dart';

/// This code defines a class called "PageCubit" that extends from another class called "Cubit". The class has three instance variables: "page", "limit", and "loadNext". It also defines a callback function called "LoadNextCallback".
///
/// The "PageCubit" class has a constructor with three parameters: "page", "limit", and "loadNext". It calls the constructor of the parent class "Cubit" with a constant value of "PageInitial".
///
/// The class also has a method called "fetch()". This method checks if the current state of the "PageCubit" is "PageInitial". If it is, it emits a "PageLoading" state. It then calls the "loadNext" callback with the "page" and "limit" parameters, and waits for the result using the "then" method.
///
/// If the result is successful, it emits a "PageLoaded" state with the items from the result. If there is an error, it checks if the error is an instance of the "Exception" class. If it is, it emits a "PageError" state with the error. If it is not, it creates a new "Exception" instance with the error message and emits a "PageError" state with it.
///
/// If there is an error in the "then" method or in the "catchError" method, the same error handling logic is applied.
///
/// If the current state of the "PageCubit" is not "PageInitial", a message is printed to the console indicating that the page is not in the initial state.
class PageCubit<T extends Object> extends Cubit<PageState> {
  /// PageCubit fetch data for specific page with index [page] and [limit] by Future function [loadNext]
  PageCubit(this.page, this.limit, this.loadNext) : super(const PageInitial());

  /// Page index
  final int page;

  /// Standard pageSize or limit for request
  final int limit;

  /// External function for fetch data
  final LoadNextCallback<T> loadNext;

  /// Fetch call loading once if the current state is PageInitial. Otherwise, is fetch ignored.
  ///
  /// Fech change state to PageLoading and then call the `loadNext(page, limit)` function.
  void fetch() {
    if (state is! PageInitial) return;
    emit(const PageLoading());
    loadNext(page, limit)
        .then(
      (value) => emit(PageLoaded(value.items)),
      onError: (Object error) => emit(PageError(error)),
    )
        .catchError((Object error) {
      emit(PageError(error));
    });
  }
}
