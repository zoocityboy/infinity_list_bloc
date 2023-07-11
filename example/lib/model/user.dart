import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:infinite_listview_bloc/infinite_listview_bloc.dart';

class User extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
  });
  factory User.fake() {
    final faker = Faker();
    return User(
      id: faker.randomGenerator.integer(20000),
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      email: faker.internet.email(),
      imageUrl: faker.image.image(
        width: 800,
        height: 800,
        keywords: ['nature', 'animal', 'space'],
        random: true,
      ),
    );
  }

  @override
  List<Object> get props => [id, firstName, lastName, email];

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? imageUrl,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
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
