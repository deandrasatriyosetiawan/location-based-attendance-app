import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  bool canPop() => Navigator.canPop(this);

  void pop() => Navigator.pop(this);

  void push({required Widget destinationPage}) =>
      Navigator.push(this, MaterialPageRoute<Widget>(builder: (_) => destinationPage));

  void pushAndRemoveUntil({required Widget destinationPage, RoutePredicate? routePredicate}) =>
      Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute<Widget>(builder: (_) => destinationPage),
        routePredicate ?? (_) => false,
      );

  void pushNamed({required String pageRoute, Object? arguments}) =>
      Navigator.pushNamed(this, pageRoute, arguments: arguments);

  void pushNamedAndRemoveUntil({required String pageRoute, RoutePredicate? routePredicate, Object? arguments}) =>
      Navigator.pushNamedAndRemoveUntil(this, pageRoute, routePredicate ?? (_) => false, arguments: arguments);
}
