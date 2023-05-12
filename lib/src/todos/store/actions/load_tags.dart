import 'package:sa_flutter_flux_sample/src/todos/store/data/task_priority.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';
import 'package:sa_flutter_flux/sa_flutter_flux.dart';

class LoadTagsParams {
  int projectId;
  LoadTagsParams({required this.projectId});
}

class LoadTags extends StoreAction<TodoStore, LoadTagsParams, List<Tag>> {
  LoadTags(super.payload);

  @override
  Future<void> apply(store, result) {
    return store.commit(TagEvents.loaded, result);
  }

  @override
  Future<List<Tag>> effect(store) async {
    try {
      store.commit(TagEvents.loading, true);
      // make api call using payload.projectId
      // dummy process
      await Future.delayed(const Duration(seconds: 1));
      return [
        Tag(id: 1, level: 1, name: 'Informative'),
        Tag(id: 2, level: 2, name: 'Bug'),
        Tag(id: 3, level: 3, name: 'Critical'),
      ];
    } catch (e) {
      rethrow;
    } finally {
      store.commit(TagEvents.loading, false);
    }
  }
}
