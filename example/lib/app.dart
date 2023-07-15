import 'package:example/core/service_provider.dart';
import 'package:example/presentation/pages/feed_page.dart';
import 'package:example/presentation/pages/home_page.dart';
import 'package:example/presentation/pages/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'repository/post_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ServiceProvider(create: (context) => DefaultCacheManager()),
        RepositoryProvider(
          create: (context) => PostRepository(
            pageSize: 20,
            totalCount: 10205,
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            pageSize: 20,
            totalCount: 10205,
          ),
        ),
      ],
      child: MaterialApp(
          title: 'Infinite ListView with Cubit',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 16, 60, 180),
              background: Colors.black,
              surface: const Color.fromARGB(255, 20, 20, 20),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          initialRoute: '/home',
          routes: {
            '/home': (context) => const HomePage(),
            '/feed': (context) => const FeedPage(),
            '/user': (context) => const UserListPage(),
          }),
    );
  }
}
