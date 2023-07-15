// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(page: 0, reverse: false));
  void go(int page) {
    final newState = NavigationState(page: page, reverse: state.page < page);
    emit(newState);
  }

  @override
  void onChange(Change<NavigationState> change) {
    print('onChange ${change.nextState}');
    super.onChange(change);
  }
}

class NavigationState extends Equatable {
  final int page;
  final bool reverse;
  const NavigationState({
    required this.page,
    required this.reverse,
  });

  @override
  List<Object?> get props => [page, reverse];

  @override
  bool get stringify => true;
}
