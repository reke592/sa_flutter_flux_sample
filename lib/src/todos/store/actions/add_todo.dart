import 'package:sa_flutter_flux/sa_flutter_flux.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/employee.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/project.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';

class AddTodo extends StoreAction<TodoStore, Todo> {
  Project project;
  Employee? assignedEmployee;
  Stage? stage;
  String task;

  AddTodo({
    required this.project,
    required this.task,
    this.assignedEmployee,
    this.stage,
  });

  @override
  Future<void> apply(TodoStore store, Todo result) {
    return store.commit(TodoTypeEvents.created, result);
  }

  @override
  Future<Todo> effect(TodoStore store) async {
    if (task.trim().isEmpty) {
      throw localString.eTaskDescriptionRequired;
    }
    if (assignedEmployee != null &&
        (stage?.isInitial == true || stage == null)) {
      throw localString.eMustUpdateStage;
    }
    if (stage?.isInitial == false && assignedEmployee == null) {
      throw localString.eMustAssignManpower;
    }
    return Todo(
      id: store.nextTodoId,
      project: project,
      task: task,
      assignedEmployee: assignedEmployee,
      stage: stage ?? store.stages.firstWhere((element) => element.isInitial),
    );
  }
}
