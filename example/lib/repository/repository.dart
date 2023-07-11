import 'package:infinite_listview_bloc/infinite_listview_bloc.dart';

import '../model/user.dart';

class UserRepository {
  UserRepository({
    required this.pageSize,
    required this.totalCount,
  });
  final int pageSize;
  final int totalCount;
  int get totalPages => (totalCount + pageSize - 1) ~/ pageSize;
  Future<Pagable<User>> list({int page = 0, int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final offset = page * limit;
    final pages = totalPages - 1;
    int count = 0;
    if (page < pages) {
      count = limit;
    } else if (page == pages) {
      count = totalCount - offset;
    }
    return Pagable<User>(
      items: List.generate(count, (index) => User.fake()),
      totalCount: totalCount,
      page: page,
      pageSize: limit,
      totalPages: totalPages,
    );
  }
}

typedef Range = (int offset, int limit);
