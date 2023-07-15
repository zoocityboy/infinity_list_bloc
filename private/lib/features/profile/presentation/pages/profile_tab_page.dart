import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ProfileTabPage extends StatelessWidget {
  const ProfileTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Profile'),
            actions: [
              IconButton.filledTonal(
                icon: const Icon(Symbols.notification_multiple_rounded),
                onPressed: () {},
              )
            ],
          ),
          SliverList.builder(
            itemBuilder: (context, index) => Card(
              child: SizedBox(height: MediaQuery.of(context).size.width * .66),
            ),
          )
        ],
      ),
    );
  }
}
