import 'package:sa_flutter_flux/sa_flutter_flux.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/employee.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/project.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';

class UpdateTodo extends StoreAction<TodoStore, Todo> {
  int id;
  Project project;
  String task;
  Employee? assignedEmployee;
  Stage? stage;

  UpdateTodo({
    required this.id,
    required this.project,
    required this.task,
    this.assignedEmployee,
    this.stage,
  });

  @override
  Future<void> apply(TodoStore store, Todo result) {
    return store.commit(TodoTypeEvents.updated, result);
  }

  @override
  Future<Todo> effect(TodoStore store) async {
    if (task.trim().isEmpty) {
      throw localString.eTaskDescriptionRequired;
    }
    if (assignedEmployee != null && stage?.isInitial == true) {
      throw localString.eMustUpdateStage;
    }
    if (stage?.isInitial == false && assignedEmployee == null) {
      throw localString.eMustAssignManpower;
    }
    return Todo(
      id: id,
      project: project,
      task: task,
      assignedEmployee: assignedEmployee,
      stage: stage ?? store.stages.firstWhere((element) => element.isInitial),
    );
  }
}
