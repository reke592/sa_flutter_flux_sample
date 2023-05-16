import 'package:sa_flutter_flux/sa_flutter_flux.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/employee.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';

class LoadManpower extends StoreAction<TodoStore, List<Employee>> {
  @override
  Future<void> apply(TodoStore store, List result) {
    return store.commit(ManpowerEvents.loaded, result);
  }

  @override
  Future<List<Employee>> effect(TodoStore store) async {
    try {
      store.commit(ManpowerEvents.loading, true);
      await Future.delayed(const Duration(seconds: 1));
      return [
        Employee(id: 1, name: 'John'),
        Employee(id: 2, name: 'Max'),
        Employee(id: 3, name: 'Ann'),
        Employee(id: 4, name: 'Erric'),
      ];
    } catch (e) {
      rethrow;
    } finally {
      store.commit(ManpowerEvents.loading, false);
    }
  }
}
