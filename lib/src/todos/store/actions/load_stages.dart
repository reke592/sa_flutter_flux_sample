import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';
import 'package:sa_flutter_flux/sa_flutter_flux.dart';

class LoadStagesParams {
  int sprintId;
  LoadStagesParams({required this.sprintId});
}

class LoadStages extends StoreAction<TodoStore, LoadStagesParams, List<Stage>> {
  LoadStages(super.payload);

  @override
  Future<void> apply(store, result) {
    return store.commit(StageTypeEvents.loaded, result);
  }

  @override
  Future<List<Stage>> effect(store) async {
    try {
      store.commit(StageTypeEvents.loading, true);
      // make api call using payload.sprintId
      // dummy process
      await Future.delayed(const Duration(seconds: 2));
      return [
        Stage(id: 1, name: 'Pooling', items: []),
        Stage(id: 1, name: 'Ongoing', items: []),
        Stage(id: 1, name: 'Completed', items: []),
        Stage(id: 1, name: 'Parked', items: []),
      ];
    } catch (e) {
      rethrow;
    } finally {
      store.commit(StageTypeEvents.loading, false);
    }
  }
}
