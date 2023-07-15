// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:infinite_listview_bloc/infinite_listview_bloc.dart';

class User extends Equatable {
  final int id;
  final String nickName;
  final String firstName;
  final String lastName;
  final String email;
  final String avatarUrl;
  const User({
    required this.id,
    required this.nickName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatarUrl,
  });
  factory User.fake({bool withComments = true}) {
    final faker = Faker();

    return User(
      id: faker.randomGenerator.integer(20000),
      nickName: faker.person.name(),
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      email: faker.internet.email(),
      avatarUrl: faker.image.image(
        width: 96,
        height: 96,
        random: true,
        keywords: ['people', 'girl', 'boy'],
      ),
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      nickName,
      firstName,
      lastName,
      email,
      avatarUrl,
    ];
  }

  User copyWith({
    int? id,
    String? nickName,
    String? firstName,
    String? lastName,
    String? email,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      nickName: nickName ?? this.nickName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  String get fullName => '$firstName $lastName';
  String get initials => '${firstName[0]}${lastName[0]}';
}

class UserPageble extends Pagable<User> with EquatableMixin {
  UserPageble({
    required super.totalCount,
    required super.totalPages,
    required super.page,
    required super.pageSize,
    required super.items,
  });

  @override
  List<Object?> get props => [totalCount, totalPages, page, pageSize, items];
}
