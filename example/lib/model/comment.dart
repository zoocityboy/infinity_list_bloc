// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';

import 'user.dart';

class Comment with EquatableMixin {
  final User user;
  final String message;
  Comment({
    required this.user,
    required this.message,
  });
  factory Comment.fake() {
    final faker = Faker();
    return Comment(
      user: User.fake(withComments: false),
      message: faker.lorem.sentence(),
    );
  }

  @override
  List<Object> get props => [user, message];

  Comment copyWith({
    User? user,
    String? message,
  }) {
    return Comment(
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }
}
