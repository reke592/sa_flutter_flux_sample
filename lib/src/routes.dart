import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/settings/settings_controller.dart';
import 'package:sa_flutter_flux_sample/src/settings/settings_view.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/stages_screen.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/tags_screen.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/tasks_screen.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/todos_page.dart';

class Routes {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final todosNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: TasksScreen.routeName,
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => TasksScreen.routeName,
        builder: (context, state) => const SizedBox(),
      ),
      ShellRoute(
        navigatorKey: todosNavigatorKey,
        builder: (context, state, child) {
          return TodosPage(state: state, child: child);
        },
        routes: [
          GoRoute(
            path: TasksScreen.routeName,
            pageBuilder: noTransition(
              builder: (context, state) => const TasksScreen(),
            ),
          ),
          GoRoute(
            path: TagsScreen.routeName,
            pageBuilder: noTransition(
              builder: (context, state) => const TagsScreen(),
            ),
          ),
          GoRoute(
            path: StagesScreen.routeName,
            pageBuilder: noTransition(
              builder: (context, state) => const StagesScreen(),
            ),
          ),
          GoRoute(
            path: SettingsView.routeName,
            parentNavigatorKey: todosNavigatorKey,
            pageBuilder: noTransition(
              builder: (context, state) {
                return SettingsView(
                  controller: context.watch<SettingsController>(),
                );
              },
            ),
          ),
        ],
      ),
    ],
  );

  Page<dynamic> Function(BuildContext, GoRouterState) noTransition(
      {required Widget Function(BuildContext context, GoRouterState state)
          builder}) {
    return (context, state) => NoTransitionPage(child: builder(context, state));
  }

  RouterConfig<Object> get config => _router;
}
