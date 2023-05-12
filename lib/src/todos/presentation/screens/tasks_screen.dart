import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/todo_dialogs.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class TasksScreen extends StatefulWidget {
  static const routeName = '/tasks';
  const TasksScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TasksScreen();
}

class _TasksScreen extends State<TasksScreen> {
  late final TabController tabController;
  late final TodoStore store;

  @override
  void initState() {
    store = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<TodoStore, List<Stage>>(
      selector: (_, pvd) => pvd.stages,
      builder: (context, stages, child) {
        return DefaultTabController(
          length: stages.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text(localString.lTaskScreenTitle),
              bottom: TabBar(
                tabs: stages.map((e) => Tab(text: e.name)).toList(),
                isScrollable: true,
              ),
            ),
            body: TabBarView(
              children: stages.map((e) {
                return Selector<TodoStore, List<Todo>>(
                  selector: (_, pvd) => pvd.todosPerStage(e),
                  builder: (context, list, child) {
                    debugPrint('$runtimeType.build');
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(list[index].task),
                          onTap: () => TodoDialogs.showTodoForm(context,
                              data: list[index]),
                        );
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget tabBar() {
    return Selector<TodoStore, List<Stage>>(
      builder: (context, list, child) {
        return TabBar(
          tabs: list
              .map(
                (e) => Tab(
                  text: e.name,
                ),
              )
              .toList(),
        );
      },
      selector: (_, store) => store.stages,
    );
  }
}
