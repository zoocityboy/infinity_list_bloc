import 'package:flutter/widgets.dart';

import '../../infinite_listview_bloc.dart';

class LoadingPlaceholder<T extends Object> extends StatelessWidget {
  const LoadingPlaceholder({
    required this.limit,
    super.key,
    this.itemBuilder,
    this.itemExtent,
  });
  final IndexedWidgetBuilder? itemBuilder;
  final int limit;
  final double? itemExtent;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemExtent: itemExtent,
      itemBuilder: itemBuilder ??
          (context, index) {
            return const ItemPlaceholder();
          },
      itemCount: limit,
    );
  }
}
