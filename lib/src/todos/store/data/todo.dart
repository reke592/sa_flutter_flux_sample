import 'package:sa_flutter_flux_sample/src/commons/entity.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/employee.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/project.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';

class Todo extends IEntity<int, Todo> {
  final Project project;
  final String task;
  final String remarks;
  final DateTime? dateCreated;
  final DateTime? dateStarted;
  final DateTime? dateCompleted;

  final Stage stage;
  final Employee? assignedEmployee;

  Todo({
    required super.id,
    required this.project,
    required this.task,
    this.remarks = '',
    this.dateCreated,
    this.dateStarted,
    this.dateCompleted,
    required this.stage,
    this.assignedEmployee,
  });

  @override
  copyWith({
    int? id,
    Project? project,
    String? task,
    String? remarks,
    DateTime? dateCreated,
    DateTime? dateStarted,
    DateTime? dateCompleted,
    Stage? stage,
    Employee? assignedEmployee,
  }) {
    return Todo(
      id: id ?? this.id,
      project: project ?? this.project,
      task: task ?? this.task,
      remarks: remarks ?? this.remarks,
      dateCreated: dateCreated ?? this.dateCreated,
      dateStarted: dateStarted ?? this.dateStarted,
      dateCompleted: dateCompleted ?? this.dateCompleted,
      stage: stage ?? this.stage,
      assignedEmployee: assignedEmployee ?? this.assignedEmployee,
    );
  }

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'task': task,
      'remarks': remarks,
      'date_created': dateCreated?.toIso8601String(),
      'date_started': dateStarted?.toIso8601String(),
      'date_completed': dateCompleted?.toIso8601String(),
      'stage': stage.asMap(),
      'assigned_to': assignedEmployee?.asMap(),
    };
  }
}
