import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/todo_dialogs.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class StagesScreen extends StatelessWidget {
  static const routeName = '/stages';
  const StagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localString.lStagesScreenTitle),
      ),
      body: Selector<TodoStore, List<Stage>>(
        selector: (_, pvd) => pvd.stages,
        builder: (context, list, child) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              var stage = list[index];
              return ListTile(
                dense: true,
                title: Text(
                  '${stage.name} ${stage.isInitial ? '(${localString.lInitialStage})' : ''} ',
                ),
                onTap: () => TodoDialogs.showStageForm(
                  context,
                  data: stage,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
