// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:example/model/user.dart';
import 'package:faker/faker.dart';
import 'package:infinite_listview_bloc/infinite_listview_bloc.dart';

import 'comment.dart';

class Post extends Equatable {
  final int id;
  final User user;
  final int likes;
  final String imageUrl;
  final List<Comment> comments;
  const Post({
    required this.id,
    required this.user,
    this.likes = 10,
    required this.imageUrl,
    this.comments = const [],
  });
  factory Post.fake({bool withComments = true}) {
    final faker = Faker();

    final comments = withComments
        ? List<Comment>.generate(
            faker.randomGenerator.integer(250), (index) => Comment.fake())
        : <Comment>[];
    return Post(
      id: faker.randomGenerator.integer(20000),
      user: User.fake(),
      likes: faker.randomGenerator.integer(1000),
      imageUrl: faker.image.image(
        width: 800,
        height: 800,
        keywords: ['nature', 'animal', 'space'],
        random: true,
      ),
      comments: comments,
    );
  }

  @override
  List<Object> get props => [id, user, likes, comments];

  Post copyWith({
    int? id,
    User? user,
    int? likes,
    String? imageUrl,
    List<Comment>? comments,
  }) {
    return Post(
      id: id ?? this.id,
      user: user ?? this.user,
      likes: likes ?? this.likes,
      imageUrl: imageUrl ?? this.imageUrl,
      comments: comments ?? this.comments,
    );
  }
}

class PostPageble extends Pagable<Post> with EquatableMixin {
  PostPageble({
    required super.totalCount,
    required super.totalPages,
    required super.page,
    required super.pageSize,
    required super.items,
  });

  @override
  List<Object?> get props => [totalCount, totalPages, page, pageSize, items];
}
