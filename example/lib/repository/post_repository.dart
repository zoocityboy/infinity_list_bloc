import 'package:example/model/post.dart';
import 'package:infinite_listview_bloc/infinite_listview_bloc.dart';

import '../model/user.dart';

const fakeDelay = 350;
typedef Range = (int offset, int limit);

abstract class BaseRepository {
  BaseRepository({
    required this.pageSize,
    required this.totalCount,
  });
  final int pageSize;
  final int totalCount;
}

mixin RepositoryMixin on BaseRepository {
  int get totalPages => (totalCount + pageSize - 1) ~/ pageSize;
  int calculateCount(int page, int limit) {
    final offset = page * limit;
    final pages = totalPages - 1;

    if (page < pages) {
      return limit;
    } else if (page == pages) {
      return totalCount - offset;
    } else {
      return 0;
    }
  }
}

class PostRepository extends BaseRepository with RepositoryMixin {
  PostRepository({required super.pageSize, required super.totalCount});

  Future<Pagable<Post>> list({int page = 0, int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: fakeDelay));
    int count = calculateCount(page, limit);
    return Pagable<Post>(
      items: List.generate(count, (index) => Post.fake()),
      totalCount: totalCount,
      page: page,
      pageSize: limit,
      totalPages: totalPages,
    );
  }
}

class UserRepository extends BaseRepository with RepositoryMixin {
  UserRepository({required super.pageSize, required super.totalCount});
  Future<Pagable<User>> list({int page = 0, int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: fakeDelay));
    int count = calculateCount(page, limit);
    return Pagable<User>(
      items: List.generate(count, (index) => User.fake(withComments: true)),
      totalCount: totalCount,
      page: page,
      pageSize: limit,
      totalPages: totalPages,
    );
  }
}
