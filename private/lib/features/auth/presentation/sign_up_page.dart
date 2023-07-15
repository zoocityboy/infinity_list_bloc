import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 16,
          ),
          FilledButton(
            child: const Text('Dashboard'),
            onPressed: () => context.goNamed('dashboard'),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white54),
              children: [
                const TextSpan(
                  text: 'By signing up, you agree to our ',
                ),
                TextSpan(
                  text: 'Terms of Services',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.white70,
                      ),
                ),
                const TextSpan(
                  text: '. ',
                ),
                TextSpan(
                  text: 'Privacy policy',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.white70,
                      ),
                ),
                const TextSpan(
                  text: ' and ',
                ),
                TextSpan(
                  text: 'Content policy',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.white70,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
