import 'package:example/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 16, 60, 180),
          background: const Color.fromARGB(255, 19, 19, 19),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => UserRepository(
          pageSize: 20,
          totalCount: 10205,
        ),
        child: const HomePage(),
      ),
    );
  }
}
