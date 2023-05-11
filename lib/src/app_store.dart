import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/app.dart';
import 'package:sa_flutter_flux_sample/src/commons/responsive_provider.dart';
import 'package:sa_flutter_flux_sample/src/routes.dart';
import 'package:sa_flutter_flux_sample/src/settings/settings_controller.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class MyAppWithStore extends StatelessWidget {
  const MyAppWithStore({
    super.key,
    required this.settingsController,
    required this.routes,
  });

  final SettingsController settingsController;
  final Routes routes;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => settingsController),
        ChangeNotifierProvider(create: (_) => ResponsiveProvider()),
        ChangeNotifierProvider(create: (_) => TodoStore()),
      ],
      builder: (context, child) => LayoutBuilder(
        builder: (context, constraint) {
          context
              .read<ResponsiveProvider>()
              .checkResponsive(context, constraint);
          return MyApp(
            settingsController: settingsController,
            routes: routes,
          );
        },
      ),
    );
  }
}
