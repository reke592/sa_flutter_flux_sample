import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';
import 'package:sa_flutter_flux/sa_flutter_flux.dart';

class LoadTodoParams {
  int projectId;
  LoadTodoParams({required this.projectId});
}

class LoadTodo extends StoreAction<TodoStore, LoadTodoParams, List<Todo>> {
  LoadTodo(super.payload);

  @override
  Future<void> apply(store, result) {
    return store.commit(TodoTypeEvents.loaded, result);
  }

  @override
  Future<List<Todo>> effect(store) async {
    try {
      store.commit(TodoTypeEvents.loading, true);
      // make api call using payload.projectId
      // dummy process
      await Future.delayed(const Duration(seconds: 1));
      return [];
    } catch (e) {
      rethrow;
    } finally {
      store.commit(TodoTypeEvents.loading, false);
    }
  }
}
