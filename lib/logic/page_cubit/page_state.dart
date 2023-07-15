part of 'page_cubit.dart';

/// Page State for Page Cubit
sealed class PageState<T extends Object> with EquatableMixin {
  const PageState({this.limit = 10});
  final int limit;

  @override
  List<Object> get props => [limit];
}

class PageInitial extends PageState {
  const PageInitial();
}

class PageLoading extends PageState {
  const PageLoading();
}

class PageLoaded<T> extends PageState {
  const PageLoaded(this.items);
  final List<T> items;
  @override
  List<Object> get props => [limit, items];
}

/// Simple Error state for page loading
class PageError extends PageState {
  PageError(Object error) {
    if (error is Exception) {
      exception = error;
    } else {
      exception = Exception(error.toString());
    }
  }
  late final Exception exception;
  @override
  List<Object> get props => [limit, exception];
}
