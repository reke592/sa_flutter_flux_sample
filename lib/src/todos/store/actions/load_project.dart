import 'package:sa_flutter_flux/sa_flutter_flux.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/project.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';

class LoadProjectParams {
  int projectId;
  LoadProjectParams({
    required this.projectId,
  });
}

class LoadProject extends StoreAction<TodoStore, LoadProjectParams, Project> {
  LoadProject(super.payload);

  @override
  Future<void> apply(TodoStore store, Project result) {
    return store.commit(ProjectEvents.loaded, result);
  }

  @override
  Future<Project> effect(TodoStore store) async {
    return Project(
      id: payload.projectId,
      project: 'Project X',
      dateKickOff: DateTime(2023, 5, 11),
      dateLive: DateTime(2024, 1, 1),
    );
  }
}
