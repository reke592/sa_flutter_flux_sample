import 'package:sa_flutter_flux/sa_flutter_flux.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/employee.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/project.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';

class UpdateTodoParams {
  int id;
  Project project;
  String task;
  Employee? assignedEmployee;
  Stage? stage;

  UpdateTodoParams({
    required this.id,
    required this.project,
    required this.task,
    this.assignedEmployee,
    this.stage,
  });
}

class UpdateTodo extends StoreAction<TodoStore, UpdateTodoParams, Todo> {
  UpdateTodo(super.payload);

  @override
  Future<void> apply(TodoStore store, Todo result) {
    return store.commit(TodoTypeEvents.updated, result);
  }

  @override
  Future<Todo> effect(TodoStore store) async {
    if (payload.task.trim().isEmpty) {
      throw localString.eTaskDescriptionRequired;
    }
    if (payload.assignedEmployee != null && payload.stage?.isInitial == true) {
      throw localString.eMustUpdateStage;
    }
    if (payload.stage?.isInitial == false && payload.assignedEmployee == null) {
      throw localString.eMustAssignManpower;
    }
    return Todo(
      id: payload.id,
      project: payload.project,
      task: payload.task,
      assignedEmployee: payload.assignedEmployee,
      stage: payload.stage ??
          store.stages.firstWhere((element) => element.isInitial),
    );
  }
}
