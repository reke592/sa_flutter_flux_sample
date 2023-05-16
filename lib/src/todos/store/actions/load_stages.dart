import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';
import 'package:sa_flutter_flux/sa_flutter_flux.dart';

class LoadStages extends StoreAction<TodoStore, List<Stage>> {
  int projectId;
  LoadStages({required this.projectId});

  @override
  Future<void> apply(store, result) {
    return store.commit(StageTypeEvents.loaded, result);
  }

  @override
  Future<List<Stage>> effect(store) async {
    try {
      store.commit(StageTypeEvents.loading, true);
      // make api call using payload.projectId
      // dummy process
      await Future.delayed(const Duration(seconds: 1));
      return [
        Stage(id: 1, name: 'Unassigned', isInitial: true),
        Stage(id: 2, name: 'Ongoing', isInitial: false),
        Stage(id: 3, name: 'Completed', isInitial: false),
        Stage(id: 4, name: 'Parked', isInitial: false),
      ];
    } catch (e) {
      rethrow;
    } finally {
      store.commit(StageTypeEvents.loading, false);
    }
  }
}
