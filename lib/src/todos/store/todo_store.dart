library sa_flutter_flux;

import 'package:sa_flutter_flux_sample/src/todos/store/data/task_priority.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';
import 'package:sa_flutter_flux/sa_flutter_flux.dart';

class TodoStore extends FluxStore {
  // state
  bool _isLoadingTodos = false;
  bool _isLoadingStages = false;
  bool _isLoadingTags = false;
  final List<Stage> _stages = [];
  final List<Tag> _tags = [];
  final List<Todo> _todos = [];

  // computed
  int get nextTodoId => _todos.length;
  bool get isLoadingTodos => _isLoadingTodos;
  List<Todo> get todos => List.of(_todos);

  int get nextStageId => _stages.length + 1;
  bool get isLoadingStages => _isLoadingStages;
  List<Stage> get stages => List.of(_stages);

  int get nextTaskPriorityId => _tags.length + 1;
  bool get isLoadingTags => _isLoadingTags;
  List<Tag> get tags => List.of(_tags);

  // mutations
  @override
  StoreMutations createMutations() {
    return {
      // todos
      TodoTypeEvents.loading: (payload) {
        _isLoadingTodos = payload == true;
      },
      TodoTypeEvents.loaded: (payload) {
        _todos.clear();
        _todos.addAll(payload as List<Todo>);
      },
      // stages
      StageTypeEvents.loading: (payload) {
        _isLoadingStages = payload == true;
      },
      StageTypeEvents.loaded: (payload) {
        _stages.clear();
        _stages.addAll(payload as List<Stage>);
      },
      // tags
      TagEvents.loading: (payload) {
        _isLoadingTags = payload == true;
      },
      TagEvents.loaded: (payload) {
        _tags.clear();
        _tags.addAll(payload as List<Tag>);
      }
    };
  }
}
