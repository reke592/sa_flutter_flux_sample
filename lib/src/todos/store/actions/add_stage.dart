import 'package:sa_flutter_flux/sa_flutter_flux.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';

class AddStage extends StoreAction<TodoStore, Stage> {
  final String name;
  final bool isInitial;
  AddStage({
    required this.name,
    required this.isInitial,
  });

  @override
  Future<void> apply(TodoStore store, Stage result) {
    return store.commit(StageTypeEvents.created, result);
  }

  @override
  Future<Stage> effect(TodoStore store) async {
    return Stage(
      id: store.nextStageId,
      name: name,
      isInitial: isInitial,
    );
  }
}
