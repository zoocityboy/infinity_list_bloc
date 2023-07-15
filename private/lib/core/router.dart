import 'package:go_router/go_router.dart';
import 'package:personal/features/auth/presentation/entry_page.dart';

import '../features/auth/presentation/sign_in_page.dart';
import '../features/auth/presentation/sign_up_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      name: 'entry',
      builder: (context, state) => const EntryPage(),
      routes: [
        GoRoute(
          path: 'sign_up',
          name: 'signup',
          builder: (context, state) => const SignUpPage(),
        ),
        GoRoute(
          path: 'sign_in',
          name: 'signin',
          builder: (context, state) => const SignInPage(),
        )
      ]),
  GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => DashboardPage())
]);
