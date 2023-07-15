import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/feed');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Image.asset(
                          'assets/feed.webp',
                          width: 64,
                          height: 64,
                        )),
                        Text(
                          'Instagram feed',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/user');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Image.asset(
                          'assets/user.webp',
                          width: 64,
                          height: 64,
                        )),
                        Text(
                          'User list',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ));
  }
}
