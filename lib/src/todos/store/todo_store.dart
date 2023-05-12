library sa_flutter_flux;

import 'package:flutter/material.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/employee.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/project.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/task_priority.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/type_events.dart';
import 'package:sa_flutter_flux/sa_flutter_flux.dart';

class TodoStore extends FluxStore {
  // state
  Project _project = Project.empty();
  bool _isLoadingTodos = false;
  bool _isLoadingStages = false;
  bool _isLoadingTags = false;
  bool _isLoadingManpower = false;
  final List<Stage> _stages = [];
  final List<Tag> _tags = [];
  final List<Todo> _todos = [];
  final List<Employee> _manpower = [];

  // computed
  Project get project => _project;
  int get nextTodoId => _todos.length + 1;
  bool get isLoadingTodos => _isLoadingTodos;
  List<Todo> get todos => List.of(_todos);
  bool get isLoadingManpower => _isLoadingManpower;
  List<Employee> get manpower => List.of(_manpower);
  int get nextStageId => _stages.length + 1;
  bool get isLoadingStages => _isLoadingStages;
  List<Stage> get stages => List.of(_stages);
  int get nextTaskPriorityId => _tags.length + 1;
  bool get isLoadingTags => _isLoadingTags;
  List<Tag> get tags => List.of(_tags);
  List<Todo> todosPerStage(Stage stage) =>
      List.of(_todos.where((element) => element.stage.id == stage.id)).toList();

  @override
  Future<void> commit(String event, dynamic result) {
    debugPrint(event);
    return super.commit(event, result);
  }

  // mutations
  @override
  StoreMutations createMutations() {
    return {
      // sprint
      ProjectEvents.loaded: (payload) {
        var data = payload as Project;
        _project = _project.copyWith(
          id: data.id,
          project: data.project,
          dateKickOff: data.dateKickOff,
          dateLive: data.dateLive,
        );
      },
      // todos
      TodoTypeEvents.loading: (payload) {
        _isLoadingTodos = payload == true;
      },
      TodoTypeEvents.loaded: (payload) {
        _todos.clear();
        _todos.addAll(payload as List<Todo>);
      },
      TodoTypeEvents.created: (payload) {
        var data = payload as Todo;
        _todos.add(data);
      },
      TodoTypeEvents.updated: (payload) {
        var updated = payload as Todo;
        var current = _todos.indexWhere((element) => element.id == updated.id);
        _todos[current] = _todos[current].copyWith(
          id: updated.id,
          task: updated.task,
          assignedEmployee: updated.assignedEmployee,
          dateCompleted: updated.dateCompleted,
          dateCreated: updated.dateCreated,
          dateStarted: updated.dateStarted,
          remarks: updated.remarks,
          project: updated.project,
          stage: updated.stage,
        );
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
      },
      // manpower
      ManpowerEvents.loading: (payload) {
        _isLoadingManpower = payload == true;
      },
      ManpowerEvents.loaded: (payload) {
        _manpower.clear();
        _manpower.addAll(payload as List<Employee>);
      },
      ManpowerEvents.added: (payload) {
        var data = payload as Employee;
        _manpower.add(data);
      },
      ManpowerEvents.removed: (payload) {
        var data = payload as Employee;
        _manpower.remove(data);
      }
    };
  }
}
