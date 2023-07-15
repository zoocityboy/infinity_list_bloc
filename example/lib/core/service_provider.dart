import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// {@template repository_provider}
/// Takes a [Create] function that is responsible for creating the repository
/// and a `child` which will have access to the repository via
/// `ServiceProvider.of(context)`.
/// It is used as a dependency injection (DI) widget so that a single instance
/// of a repository can be provided to multiple widgets within a subtree.
///
/// ```dart
/// ServiceProvider(
///   create: (context) => RepositoryA(),
///   child: ChildA(),
/// );
/// ```
///
/// Lazily creates the repository unless `lazy` is set to `false`.
///
/// ```dart
/// ServiceProvider(
///   lazy: false,`
///   create: (context) => RepositoryA(),
///   child: ChildA(),
/// );
/// ```
/// {@endtemplate}
class ServiceProvider<T> extends Provider<T> {
  /// {@macro repository_provider}
  ServiceProvider({
    required Create<T> create,
    Key? key,
    Widget? child,
    bool? lazy,
  }) : super(
          key: key,
          create: create,
          dispose: (_, __) {},
          child: child,
          lazy: lazy,
        );

  /// Takes a repository and a [child] which will have access to the repository.
  /// A new repository should not be created in `ServiceProvider.value`.
  /// Repositories should always be created using the default constructor
  /// within the [Create] function.
  ServiceProvider.value({
    required T value,
    Key? key,
    Widget? child,
  }) : super.value(
          key: key,
          value: value,
          child: child,
        );

  /// Method that allows widgets to access a repository instance as long as
  /// their `BuildContext` contains a [ServiceProvider] instance.
  static T of<T>(BuildContext context, {bool listen = false}) {
    try {
      return Provider.of<T>(context, listen: listen);
    } on ProviderNotFoundException catch (e) {
      if (e.valueType != T) rethrow;
      throw FlutterError(
        '''
        ServiceProvider.of() called with a context that does not contain a repository of type $T.
        No ancestor could be found starting from the context that was passed to ServiceProvider.of<$T>().

        This can happen if the context you used comes from a widget above the ServiceProvider.

        The context used was: $context
        ''',
      );
    }
  }
}
