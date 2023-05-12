import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/commons/parsers.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class ProjectInfoScreen extends StatelessWidget {
  static const routeName = '/project-info';

  const ProjectInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yMMMMd');
    return Consumer<TodoStore>(
      builder: (context, store, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  store.project.project,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Kick-off: ${tryDateFormat(dateFormat, store.project.dateKickOff) ?? 'n/a'}',
                ),
                Text(
                  'Target Live: ${tryDateFormat(dateFormat, store.project.dateLive) ?? 'n/a'}',
                ),
                const SizedBox(width: 30, child: Divider()),
                Text(
                  localString.lTaskScreenTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ...store.stages.map((stage) => Text(
                    '${stage.name}: ${store.todosPerStage(stage).length}')),
                const SizedBox(width: 30, child: Divider()),
                Text(
                  localString.lManpowerScreenTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ...store.manpower.map((e) => Text(e.name)),
              ],
            ),
          ),
        );
      },
    );
  }
}
