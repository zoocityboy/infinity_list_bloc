import 'package:flutter/material.dart';

import '../theme/infinite_listview_theme.dart';

class ItemSeparator extends StatelessWidget {
  const ItemSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: InfiniteListViewTheme.of(context).separatorColor,
      height: 1,
    );
  }
}
