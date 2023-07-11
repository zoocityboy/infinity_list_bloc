import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InfiniteListViewThemeData with Diagnosticable {
  InfiniteListViewThemeData({
    this.primaryColor,
  });
  final Color? primaryColor;
}

class InfiniteListViewTheme extends InheritedTheme {
  /// Creates a popup menu theme that controls the configurations for
  /// popup menus in its widget subtree.
  ///
  /// The data argument must not be null.
  const InfiniteListViewTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// The properties for descendant popup menu widgets.
  final InfiniteListViewThemeData data;
  static InfiniteListViewThemeData general(BuildContext context) {
    return InfiniteListViewThemeData();
  }

  /// The closest instance of this class's [data] value that encloses the given
  /// context. If there is no ancestor, it returns [ThemeData.popupMenuTheme].
  /// Applications can assume that the returned value will not be null.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// InfiniteListViewThemeData theme = InfiniteListViewTheme.of(context);
  /// ```
  static InfiniteListViewThemeData of(BuildContext context) {
    final infiniteListViewTheme = context.dependOnInheritedWidgetOfExactType<InfiniteListViewTheme>();
    return infiniteListViewTheme?.data ?? InfiniteListViewTheme.general(context);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return InfiniteListViewTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(InfiniteListViewTheme oldWidget) => data != oldWidget.data;
}
