import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/commons/responsive_provider.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/settings/settings_view.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/components/fabs/stage_screen_fab.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/components/fabs/tags_screen_fab.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/components/fabs/todos_screen_fab.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/components/loading_indicator.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/stages_screen.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/tags_screen.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/tasks_screen.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/load_stages.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/load_tags.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/load_todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class TodosPage extends StatefulWidget {
  static const routeName = 'todos';
  final Widget child;
  final GoRouterState state;

  const TodosPage({
    super.key,
    required this.child,
    required this.state,
  });

  @override
  State<StatefulWidget> createState() => _TodosPage();
}

class _TodosPage extends State<TodosPage> {
  int selectedIndex = 0;

  Widget? fab;

  final List<String> routeNames = [
    TasksScreen.routeName,
    TagsScreen.routeName,
    StagesScreen.routeName,
    SettingsView.routeName,
  ];

  final Map<String, Widget> fabs = {
    TasksScreen.routeName: const TodosScreenFab(),
    TagsScreen.routeName: const TagsScreenFab(),
    StagesScreen.routeName: const StageScreenFab(),
  };

  late final List<void Function(BuildContext)> railActions = [
    (context) {
      context.go(TasksScreen.routeName);
    },
    (context) {
      context.go(TagsScreen.routeName);
    },
    (context) {
      context.go(StagesScreen.routeName);
    },
    (context) {
      context.go(SettingsView.routeName);
    }
  ];

  final List<NavigationRailDestination> destinations = [
    NavigationRailDestination(
      icon: const Icon(Icons.task),
      label: Selector<TodoStore, int>(
        selector: (_, pvd) => pvd.todos.length,
        builder: (context, value, child) {
          return Text('${localString.lTask} ($value)');
        },
      ),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.tag),
      label: Selector<TodoStore, int>(
        selector: (_, pvd) => pvd.tags.length,
        builder: (context, value, child) {
          return Text('${localString.lTags} ($value)');
        },
      ),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.category),
      label: Selector<TodoStore, int>(
        selector: (_, pvd) => pvd.stages.length,
        builder: (context, value, child) {
          return Text('${localString.lStages} ($value)');
        },
      ),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.settings),
      label: Text(localString.lSettings),
    ),
  ];

  @override
  void initState() {
    debugPrint('-- $runtimeType.initState');
    context.read<TodoStore>()
      ..dispatch(LoadTags(LoadTagsParams(sprintId: 1)))
      ..dispatch(LoadStages(LoadStagesParams(sprintId: 1)))
      ..dispatch(LoadTodo(LoadTodoParams(sprintId: 1)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var uri = Uri.parse(widget.state.location);
    selectedIndex = routeNames.indexOf(uri.path);
    fab = fabs[uri.path];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localString.lTodos),
            const LoadingIndicator(),
          ],
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            extended:
                context.read<ResponsiveProvider>().type != Responsive.mobile,
            destinations: destinations,
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              selectedIndex = value;
              railActions[value](context);
              updateFab(selectedIndex);
            },
          ),
          const VerticalDivider(width: 8),
          Expanded(child: widget.child),
        ],
      ),
      floatingActionButton: fab,
    );
  }

  void updateFab(int index) {
    fab = fabs[routeNames[index]];
  }
}
