import 'package:flutter/material.dart';
import 'package:cashfuse/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? locale;

  // Locale get locale => _locale!;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    locale = null;
    notifyListeners();
  }
}
