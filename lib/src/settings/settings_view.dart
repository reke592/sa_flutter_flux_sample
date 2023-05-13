import 'package:flutter/material.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localString.lSettings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Wrap(
          spacing: 8,
          runSpacing: 32,
          direction: Axis.vertical,
          children: [
            themeOptions(),
            languageOptions(),
          ],
        ),
      ),
    );
  }

  Widget themeOptions() {
    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(localString.lTheme),
        DropdownButton<ThemeMode>(
          // Read the selected themeMode from the controller
          value: controller.themeMode,
          isDense: true,
          // Call the updateThemeMode method any time the user selects a theme.
          onChanged: controller.updateThemeMode,
          items: const [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text('System Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text('Light Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text('Dark Theme'),
            )
          ],
        ),
      ],
    );
  }

  Widget languageOptions() {
    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(localString.lLanguage),
        DropdownButton<Locale>(
          isDense: true,
          value: controller.locale,
          onChanged: (Locale? val) {
            controller.setLocale(val!);
          },
          items: controller.supportedLocales
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.languageCode),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
