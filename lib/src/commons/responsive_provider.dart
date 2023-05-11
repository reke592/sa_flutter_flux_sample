import 'package:flutter/material.dart';

enum Responsive {
  mobile,
  desktop,
  tablet,
}

class ResponsiveProvider extends ChangeNotifier {
  Responsive _type = Responsive.desktop;
  Responsive get type => _type;

  void checkResponsive(BuildContext context, BoxConstraints constraints) {
    late Responsive updated;
    if (constraints.maxWidth >= 1200) {
      updated = Responsive.desktop;
    } else if (constraints.maxWidth >= 600) {
      updated = Responsive.tablet;
    } else {
      updated = Responsive.mobile;
    }
    if (_type != updated) {
      _type = updated;
      debugPrint('$_type');
      Future.microtask(notifyListeners);
    }
  }
}
