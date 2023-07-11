part of 'infinite_list_cubit.dart';

sealed class InfiniteListState<T extends Object> with EquatableMixin {
  const InfiniteListState({
    this.limit = 10,
  });
  final int limit;
  @override
  List<Object?> get props => [];
}

class InitialListState<T extends Object> extends InfiniteListState {
  const InitialListState();
}

class LoadingListState<T extends Object> extends InfiniteListState {
  const LoadingListState();
}

class LoadedListState<T extends Object> extends InfiniteListState<T> {
  const LoadedListState(this.paged);
  final Pagable<T> paged;
}

class ErrorListState<T extends Object> extends InfiniteListState<T> {
  const ErrorListState(this.exception);
  final Exception exception;
}
