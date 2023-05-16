import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/commons/responsive_provider.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/settings/settings_view.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/components/fabs/manpower_fab.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/components/fabs/stage_screen_fab.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/components/fabs/tags_screen_fab.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/components/fabs/todos_screen_fab.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/components/loading_indicator.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/screens/manpower_screen.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/screens/project_info_screen.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/screens/stages_screen.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/screens/tags_screen.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/screens/tasks_screen.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/load_manpower.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/load_project.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/load_stages.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/load_tags.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/load_todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/project.dart';
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
    ProjectInfoScreen.routeName,
    TasksScreen.routeName,
    TagsScreen.routeName,
    StagesScreen.routeName,
    ManpowerScreen.routeName,
    SettingsView.routeName,
  ];

  final Map<String, Widget> fabs = {
    TasksScreen.routeName: const TodosScreenFab(),
    TagsScreen.routeName: const TagsScreenFab(),
    StagesScreen.routeName: const StageScreenFab(),
    ManpowerScreen.routeName: const ManpowerScreenFab(),
  };

  late final List<void Function(BuildContext)> railActions = [
    (context) {
      context.go(ProjectInfoScreen.routeName);
    },
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
      context.go(ManpowerScreen.routeName);
    },
    (context) {
      context.go(SettingsView.routeName);
    }
  ];

  List<NavigationRailDestination> get destinations => [
        NavigationRailDestination(
          icon: const Icon(Icons.info_outline),
          label: Selector<TodoStore, Project>(
            selector: (_, pvd) => pvd.project,
            builder: (context, value, child) {
              return Text(
                  '${localString.lProjectInfoScreenTitle} (${value.project})');
            },
          ),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.note_alt_outlined),
          label: Selector<TodoStore, int>(
            selector: (_, pvd) => pvd.countTodos,
            builder: (context, value, child) {
              return Text(
                '${localString.lTaskScreenTitle} ${value > 0 ? '($value)' : ''}',
              );
            },
          ),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.tag),
          label: Selector<TodoStore, int>(
            selector: (_, pvd) => pvd.countTags,
            builder: (context, value, child) {
              return Text(
                '${localString.lTagsScreenTitle} ${value > 0 ? '($value)' : ''}',
              );
            },
          ),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.category),
          label: Selector<TodoStore, int>(
            selector: (_, pvd) => pvd.countStages,
            builder: (context, value, child) {
              return Text(
                '${localString.lStagesScreenTitle} ${value > 0 ? '($value)' : ''}',
              );
            },
          ),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.group),
          label: Selector<TodoStore, int>(
            selector: (_, pvd) => pvd.countManpower,
            builder: (context, value, child) {
              return Text(
                '${localString.lManpowerScreenTitle} ${value > 0 ? '($value)' : ''}',
              );
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
      ..dispatch(LoadProject(projectId: 1))
      ..dispatch(LoadTags(projectId: 1))
      ..dispatch(LoadStages(projectId: 1))
      ..dispatch(LoadTodo(projectId: 1))
      ..dispatch(LoadManpower());

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
            Text(localString.lTodosPageTitle),
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
