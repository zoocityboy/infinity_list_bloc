part of 'infinite_list_cubit.dart';

sealed class InfiniteListState<T extends Object> with EquatableMixin {
  const InfiniteListState({
    this.limit = 10,
  });
  final int limit;
  @override
  List<Object?> get props => [limit];
}

/// Initial state
class InitialListState<T extends Object> extends InfiniteListState {
  const InitialListState();
}

/// Fetch of data is in progress
class LoadingListState<T extends Object> extends InfiniteListState {
  const LoadingListState();
}

/// New data are fetched [paged]
class LoadedListState<T extends Object> extends InfiniteListState<T> {
  const LoadedListState(this.paged);
  final Pagable<T> paged;
  @override
  List<Object?> get props => [limit, paged];
}

/// Fetch of data failed with [exception]
class ErrorListState<T extends Object> extends InfiniteListState<T> {
  const ErrorListState(this.exception);
  final Exception exception;
  @override
  List<Object?> get props => [limit, exception];
}
