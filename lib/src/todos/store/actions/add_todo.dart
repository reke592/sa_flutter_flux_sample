import 'package:sa_flutter_flux/sa_flutter_flux.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/employee.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/project.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';

class AddTodoParams {
  Project project;
  Employee? assignedEmployee;
  Stage? stage;
  String task;

  AddTodoParams({
    required this.project,
    required this.task,
    this.assignedEmployee,
    this.stage,
  });
}

class AddTodo extends StoreAction<TodoStore, AddTodoParams, Todo> {
  AddTodo(super.payload);

  @override
  Future<void> apply(TodoStore store, Todo result) {
    return store.commit(TodoTypeEvents.created, result);
  }

  @override
  Future<Todo> effect(TodoStore store) async {
    if (payload.task.trim().isEmpty) {
      throw localString.eTaskDescriptionRequired;
    }
    return Todo(
      id: store.nextTodoId,
      project: payload.project,
      task: payload.task,
      assignedEmployee: payload.assignedEmployee,
      stage: payload.stage ??
          store.stages.firstWhere((element) => element.isInitial),
    );
  }
}
