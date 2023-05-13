import 'package:sa_flutter_flux/sa_flutter_flux.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';

class UpdateStageParams {
  final int id;
  final String name;
  final bool isInitial;
  UpdateStageParams({
    required this.id,
    required this.name,
    required this.isInitial,
  });
}

class UpdateStage extends StoreAction<TodoStore, UpdateStageParams, Stage> {
  UpdateStage(super.payload);

  @override
  Future<void> apply(TodoStore store, Stage result) {
    return store.commit(StageTypeEvents.updated, result);
  }

  @override
  Future<Stage> effect(TodoStore store) async {
    if (payload.isInitial == false &&
        store.stages.isNotEmpty &&
        !store.stages.any((e) => e.isInitial && e.id != payload.id)) {
      throw localString.eAtleastOneInitialStage;
    }

    return Stage(
      id: payload.id,
      name: payload.name,
      isInitial: payload.isInitial,
    );
  }
}
