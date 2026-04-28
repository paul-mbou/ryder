import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension MediaQueryExtension on BuildContext {
  double get width => View.of(this).physicalSize.width;
  double get height => View.of(this).physicalSize.height;
}

extension TextThemeExtension on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension SnackbarExtension on BuildContext {
  void showSnackbar(Object message) => ScaffoldMessenger.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message.toString()),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        elevation: 0.8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
}

extension NavigatorExtension on BuildContext {
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop();

  Future<T?> push<T extends Object?>(Widget route) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (context) => route));

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Widget route, {
    TO? result,
  }) => Navigator.of(this).pushReplacement(
    MaterialPageRoute(builder: (context) => route),
    result: result,
  );

  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Widget newRoute, [
    RoutePredicate? predicate,
  ]) => Navigator.of(this).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => newRoute),
    (route) => predicate?.call(route) ?? true,
  );
}

extension StringExtension on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}

extension AsyncValueExtension<T> on AsyncValue<T> {
  void handle(BuildContext context, {VoidCallback? onSuccess}) {
    whenOrNull(
      data: (_) => onSuccess?.call(),
      error: (error, _) => context.showSnackbar(error.toString()),
    );
  }
}
